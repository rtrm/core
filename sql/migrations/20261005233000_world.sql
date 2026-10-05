-- Milestone 1 polish: give every "Teach Companion" spell a cast visual
-- (requested after live testing: "a visual effect around your character
-- for when you learn the pet, similar to when you learn a spell from a
-- trainer").
--
-- spellVisual1 was 0 (silent/invisible) on all 70 Teach spells (60001 and
-- the 69 added in 20261005230630_world.sql) - there was no original item-use
-- spell to copy a "learn" visual from, since every one of these items
-- directly summoned before milestone 1 repointed them.
--
-- 222 is not invented: it's the real, standard "you learned a spell from a
-- trainer" visual, confirmed by querying every stock LEARN_SPELL
-- (effect1=36) spell_template row and finding 222 used 1228 times across
-- trainer-learn wrappers for ordinary class spells (Frostbolt, Polymorph,
-- Frost Armor, etc. - the trainer-side "you learned this" wrapper, which
-- shares its target spell's name/icon, not the resulting spell itself).
--
-- NOTE: as with the summon/dismiss sound fix, this server-side column alone
-- is not sufficient - the client resolves a cast's visual from its OWN
-- SpellDisplay entry for that spell id, not from anything the server sends
-- over the wire. The matching client-side fix (a catalog row for every
-- Teach spell id, carrying this same visual) is required too - see
-- benilla's ui_action/synthetic_spells.rs.

UPDATE `spell_template`
SET `spellVisual1` = 222
WHERE `entry` = 60001 OR `name` LIKE 'Teach Companion:%';
