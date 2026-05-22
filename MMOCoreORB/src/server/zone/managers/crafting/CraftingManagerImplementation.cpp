/*
 				Copyright <SWGEmu>
		See file COPYING for copying conditions. */

#include "server/zone/managers/crafting/CraftingManager.h"
#include "server/zone/managers/crafting/labratories/SharedLabratory.h"
#include "server/zone/managers/crafting/labratories/ResourceLabratory.h"
#include "server/zone/managers/crafting/labratories/GeneticLabratory.h"
#include "server/zone/managers/crafting/labratories/DroidLabratory.h"

void CraftingManagerImplementation::initialize() {
	schematicMap = SchematicMap::instance();
	schematicMap->initialize(zoneServer.get());
	configureLabratories();
}

void CraftingManagerImplementation::stop() {
	schematicMap = nullptr;
}

void CraftingManagerImplementation::awardSchematicGroup(PlayerObject* playerObject, Vector<String>& schematicgroups, bool updateClient) {
	schematicMap->addSchematics(playerObject, schematicgroups, updateClient);
}

void CraftingManagerImplementation::removeSchematicGroup(PlayerObject* playerObject, Vector<String>& schematicgroups, bool updateClient) {
	schematicMap->removeSchematics(playerObject, schematicgroups, updateClient);
}

void CraftingManagerImplementation::sendDraftSlotsTo(CreatureObject* player, uint32 schematicID) {
	schematicMap->sendDraftSlotsTo(player, schematicID);
}

void CraftingManagerImplementation::sendResourceWeightsTo(CreatureObject* player, uint32 schematicID) {
	schematicMap->sendResourceWeightsTo(player, schematicID);
}

int CraftingManagerImplementation::calculateAssemblySuccess(CreatureObject* player,	DraftSchematic* draftSchematic, float effectiveness) {
	SharedLabratory* lab = labs.get(draftSchematic->getLabratory());
	return lab->calculateAssemblySuccess(player,draftSchematic,effectiveness);
}


int CraftingManagerImplementation::calculateExperimentationFailureRate(CreatureObject* player,
		ManufactureSchematic* manufactureSchematic, int pointsUsed) {
	SharedLabratory* lab = labs.get(manufactureSchematic->getLabratory());
	// Get the Weighted value of MA
	float ma = lab->getWeightedValue(manufactureSchematic, MA);

	// Get Experimentation skill
	String expSkill = manufactureSchematic->getDraftSchematic()->getExperimentationSkill();
	float expPoints = player->getSkillMod(expSkill) / 10.0f;

	int failure = int((50.0f + (ma - 500.0f) / 40.0f + expPoints - 5.0f * float(pointsUsed)));

	return failure;
}

int CraftingManagerImplementation::getCreationCount(ManufactureSchematic* manufactureSchematic) {
	SharedLabratory* lab = labs.get(manufactureSchematic->getLabratory());
	return lab->getCreationCount(manufactureSchematic);
}

int CraftingManagerImplementation::calculateExperimentationSuccess(CreatureObject* player,
		DraftSchematic* draftSchematic, float effectiveness) {

	float cityBonus = player->getSkillMod("private_spec_experimentation");

	int experimentationSkill = player->getSkillMod(draftSchematic->getExperimentationSkill());
	int forceSkill = player->getSkillMod("force_experimentation");
	experimentationSkill += forceSkill;
	experimentationSkill += player->getSkillMod("deity_techno_union");

	float experimentingPoints = ((float)experimentationSkill) / 10.0f;

	int failMitigate = (player->getSkillMod(draftSchematic->getAssemblySkill()) - 100 + cityBonus) / 7;
	failMitigate += player->getSkillMod("force_failure_reduction");

	if(failMitigate < 0)
		failMitigate = 0;
	if(failMitigate > 5)
		failMitigate = 5;

	// 0.85-1.15
	float toolModifier = 1.0f + (effectiveness / 100.0f);

	//Bespin Port
	float expbonus = 0;
	if (player->hasBuff(BuffCRC::FOOD_EXPERIMENT_BONUS)) {
		Buff* buff = player->getBuff(BuffCRC::FOOD_EXPERIMENT_BONUS);

		if (buff != nullptr) {
			expbonus = buff->getSkillModifierValue("experiment_bonus");
			toolModifier *= 1.0f + (expbonus / 100.0f);
		}
	}

	/// Range 0-100
	int luckRoll = System::random(500) + cityBonus;
	if(luckRoll > ((95 - expbonus) - forceSkill))
		return AMAZINGSUCCESS;

	if(luckRoll < (5 - expbonus - failMitigate))
		luckRoll -= System::random(100);

	//if(luckRoll < 5)
	//	return CRITICALFAILURE;

	luckRoll += System::random(player->getSkillMod("luck") + player->getSkillMod("force_luck"));

	///
	int experimentRoll = (toolModifier * (luckRoll + (experimentingPoints * 4)));

	if (experimentRoll > 70)
		return GREATSUCCESS;

	if (experimentRoll > 60)
		return GOODSUCCESS;

	if (experimentRoll > 50)
		return MODERATESUCCESS;

	if (experimentRoll > 40)
		return SUCCESS;

	if (experimentRoll > 30)
		return MARGINALSUCCESS;

	if (experimentRoll > 20)
		return OK;
	
	return OK;
}

String CraftingManagerImplementation::generateSerial() {

	StringBuffer ss;

	char a;

	ss << "(";

	for (int i = 0; i < 8; ++i) {

		a = (System::random(34));
		if (a < 9) {
			a = a + 48;
		} else {
			a -= 9;
			a = a + 97;
		}
		ss << a;
	}

	ss << ")";

	return ss.toString();
}

void CraftingManagerImplementation::experimentRow(ManufactureSchematic* schematic, CraftingValues* craftingValues, int rowEffected, int pointsAttempted, float failure, int experimentationResult) {
	int labratory = schematic->getLabratory();
	SharedLabratory* lab = labs.get(labratory);
	lab->experimentRow(craftingValues,rowEffected,pointsAttempted,failure,experimentationResult);
}

void CraftingManagerImplementation::configureLabratories() {
	ResourceLabratory* resLab = new ResourceLabratory();
	resLab->initialize(zoneServer.get());

	labs.put(static_cast<int>(DraftSchematicObjectTemplate::RESOURCE_LAB),resLab); //RESOURCE_LAB

	GeneticLabratory* genLab = new GeneticLabratory();
	genLab->initialize(zoneServer.get());
	labs.put(static_cast<int>(DraftSchematicObjectTemplate::GENETIC_LAB), genLab); //GENETIC_LAB

	DroidLabratory* droidLab = new DroidLabratory();
	droidLab->initialize(zoneServer.get());
	labs.put(static_cast<int>(DraftSchematicObjectTemplate::DROID_LAB), droidLab); //DROID_LAB
}

void CraftingManagerImplementation::setInitialCraftingValues(TangibleObject* prototype, ManufactureSchematic* manufactureSchematic, int assemblySuccess) {
	if(manufactureSchematic == nullptr || manufactureSchematic->getDraftSchematic() == nullptr)
		return;
	int labratory = manufactureSchematic->getLabratory();
	SharedLabratory* lab = labs.get(labratory);
	lab->setInitialCraftingValues(prototype,manufactureSchematic,assemblySuccess);
}

int CraftingManagerImplementation::calculateFinalJunkValue(CreatureObject* crafter, ManufactureSchematic* manufactureSchematic) {
	if(manufactureSchematic == nullptr || manufactureSchematic->getDraftSchematic() == nullptr)
		return 0;
	
	int labratory = manufactureSchematic->getLabratory();
	SharedLabratory* lab = labs.get(labratory);
	
	int baseValue = lab->getJunkValue(manufactureSchematic);
	
	// Apply small skill modifier based on player's crafting skill (reduced to prevent inflation)
	float skillMod = 0;
	String assemblySkill = manufactureSchematic->getDraftSchematic()->getAssemblySkill();
	skillMod = crafter->getSkillMod(assemblySkill) / 500.0f; // Reduced from 100 to 500
	
	// Add general crafting bonus (reduced)
	skillMod += crafter->getSkillMod("crafting_general") / 500.0f; // Reduced from 100 to 500
	
	// Cap skill modifier to prevent excessive prices
	if (skillMod > 0.5f)
		skillMod = 0.5f;
	
	// Calculate final value with skill modifier
	int finalValue = baseValue * (1.0f + skillMod);
	
	// Add small randomness (10% variance instead of 20%)
	int variance = finalValue * 0.1f;
	if (variance > 0) {
		finalValue += System::random(variance) - (variance / 2);
	}
	
	// Ensure minimum value
	if (finalValue < 1)
		finalValue = 1;
	
	return finalValue;
}
