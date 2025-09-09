create table info.strats(
    id smallserial primary key,
    boss_name text,
    thumbnail text,
    wiki_url text,
    fight_flow text,
    strats text,
    additional_info text,
    fields jsonb
);

insert into info.strats(boss_name, thumbnail, wiki_url, fight_flow, strats, additional_info, fields)
values
(   'D.Mist', 'dmist.png','https://wiki.ff4fe.com/doku.php?id=d.mist'
    , '### Fight Flow
D.Mist alternates between two phases: Attack and Mist. In the Attack phase, D.Mist punches once a turn for three turns. In Mist phase D.Mist is immune to everything and reacts to the Fight action with party-wide ice damage.'
    , '### Strats
While in the attack phase, Mages should prefer casting fast spells (e.g. Virus) so that they don''t land during mist phase. During mist phase, resurrect swooned party members, apply Blink/Illusion, and if you have a feel for the timing, queue up spells with a longer delay so that they land as D.Mist re-forms. MoonVeils are very strong in this fight. Since the player can control whether or not ColdMist comes out, Blink/Illusion and Life potion usage can often be the main way a party gets through the fight if they''re having trouble dealing with the punch damage.'
    , '### Additional Notes
Depending on the level disparity, Cover strats will have some variable utility, but can be a huge help if you have solid defensive gear (Glass hat, Crystal ring, Adamant armor, etc). Spending time using cure spells is often not advised for underleveled fights, since D.Mist might just be one-shotting characters even if they had full health.'
    , '{
    "Damage Types": "Physical, Ice (ColdMist)",
    "Resists": "Holy Absorb",
    "Boss Bit": "Yes"
}'::jsonb),

(
    'Kaipo Guards', 'Soldier.png','https://wiki.ff4fe.com/doku.php?id=officer'
    , '### Fight Flow
The Officer will command the Soldiers, causing them to react to the command and Fight. If the Officer is dead, the Soldiers will Fight each other. If the Soldiers are dead, the Officer will Retreat (no XP from the officer).'
    , '### Strats
By default, no enemies in this fight have the boss bit, and so the fight can be easily won with either a Coffin targeting the Officer, an HrGlass, or quick AoE to clear the Soldiers.'
    , '### Additional Notes
Each soldier has roughly 9% of the location''s total HP. When `Bnofree` is turned on, all the enemies will have a boss bit.'
    , '
{
    "Damage Types": "Physical",
    "Boss Bit": "No",
    "Additional Links": "[Soldier](<https://wiki.ff4fe.com/doku.php?id=soldier>)"
}'::jsonb
),

(
    'Octomamm', 'octo.png','https://wiki.ff4fe.com/doku.php?id=octomamm'
    , '### Fight Flow
Octomamm only uses physical attacks. After the third time you deal direct damage to Octo a tentacle is removed. After the first tentacle loss, every other time you deal direct damage another tentacle is lost until only one tentacle remains. Each tentacle loss slows Octomamm''s speed.'
    , '### Strats
Overall a pretty basic fight. Berserk status and fast spells are all very helpful in slowing the squid. Once you''ve gotten a few tentacles removed, Mages with Lit3 but not Nuke probably really like switching from Virus to Lit3 when the fight is at a high HP location.'
    , '### Additional Notes
A MoonVeil used against Octomamm means the fight is entirely free, and Cover strats can really help out, especially for underleveled parties. If the fight''s in a challenging spot, a SilkWeb or a double slow helps out in this fight, since the slow effect from those gets amplified by the tentacle loss. Slowing down the battle speed a notch or two can help get in extra early attacks, which''ll have some cascading benefits. Blink and Illusion can be huge in helping set up/stabilize in underleveled fights.'
    , '
{
    "Damage Types": "Physical",
    "Resist": "Holy absorb",
    "Weakness": "Dark, Lightning",
    "Boss Bit": "Yes"
}'::jsonb
),
(
    'Antlion', 'Antlion.png','https://wiki.ff4fe.com/doku.php?id=antlion'
    , '### Fight Flow
Antlion just Fights on their own turn, and will react with Counter on any character who Fights.'
    , '### Strats
Blink/Illusion/MoonVeil are the standard defensive package here, with a smattering of healing items or+ spells. Since Antlion will counter that command, which includes berserked characters, using other commands (e.g. Jump, Power, Aim) or magic to deal damage is generally preferred.'
    , '### Additional Notes
The Counter reaction bases its damage from the Physical stat at a location, and is stopped by neither Reflect nor Barrier status, so MoonVeils, Blink, Illusion, and Cover are useless against it. All those defensive options are still fantastic for helping handle the Fight damage.'
    , '
{
    "Damage Types": "Physical",
    "Boss Bit": "Yes"
}'::jsonb
),

(
    'Waterhag', 'waterhag.png','https://wiki.ff4fe.com/doku.php?id=waterhag_boss'
    , '### Fight Flow
WaterHag only does normal Fight commands, and unless `Bnofree` is turned on, will die by any three instances of direct damage from the party.'
    , '### Strats
Opt for fast attacks/spells. Zerkers are great, although prefer Avenger or Bacchus over casting the spell where possible. This is a great fight to use excess j-items that don''t pack much punch anymore.'
    , '### Additional Notes
As with any fight that only does physical/Fight damage, MoonVeil will fully solve this encounter, and Blink, Illusion, and Cover help tremendously if you''re having trouble staying alive long enough to get the three hits in. Alternatively, RA1 parties at slow battle speeds can get all their actions in before WaterHag takes a turn, which can help you take out WaterHag at high damage spots when you''re at low level.'
    , '
{
    "Damage Types": "Physical",
    "Boss Bit": "Yes"
}'::jsonb
),

(
    'MomBomb', 'Mombomb.png','https://wiki.ff4fe.com/doku.php?id=mombomb'
    , '### Fight Flow
MomBomb starts the fight just doing physical damage. When below 10,000 HP (see Additional Notes for HP details), MomBomb begins a sequence where the next turns are changing sprites, then an empty turn with a battle message, and finally using Explode, which deals damage to the party and replaces Mombomb with 3 Bombs and 3 Grey Bombs. After they each attack twice, the baby bombs will explode for their current HP to a targeted party member.'
    , '### Strats
Deal damage quickly, and when MomBomb starts the explode sequence, either stop dealing damage and set up for killing the baby bombs, or try to push through the extra HP and skip the explode/baby bomb phase of the fight entirely. For lower level strats, you''ll focus on dealing damage and surviving MomBomb''s attacks, then heal up and prep your handling of the baby bombs, which is often an HrGlass or a source of AoE damage.

If you are holding someone''s turn for any multi-target action, make to sure wait to see the cursor point at all the baby bombs before fully entering the command, otherwise you''ll only target one bomb with it.'
    , '### Additional Notes
MomBomb has 64% the spot''s HP total, plus an additional 10,000 HP (up to a max of 65,000 HP). 
Bombs have 4% the spot''s HP total.
Grey Bombs have 8% the spot''s HP total, and get no magic defenses.
None of the baby bombs have the boss bit, unless `Bnofree` is turned on.'
    , '
{
    "Damage Types": "Physical, Fire (Explode, MomBomb), Untyped Magic (Explode, baby bombs)",
    "Resist": "MomBomb: None, Baby bombs: Poison, Pig, Mini, Frog",
    "Weakness": "MomBomb: Dark, Baby bombs: none",
    "Boss Bit": "Yes (MomBomb), No (baby bombs)",
    "Additional Links": "[GrayBomb](<https://wiki.ff4fe.com/doku.php?id=graybomb>),[Bomb](<https://wiki.ff4fe.com/doku.php?id=bomb>)"
}'::jsonb
)
,
(
    'Fabul Gauntlet', 'Gauntlet.png','https://wiki.ff4fe.com/doku.php?id=general'
    , '### Fight Flow
The vanilla Fabul Gauntlet consists of six consecutive fights. The first, third, and sixth fights are against a General/2x Fighter composition, the second and fifth have a Weeper, WaterHag, and Imp Captain, and the fourth fight is against a solo Gargoyle.'
    , '### Strats
A vanilla Gauntlet generally poses little threat, since the total HP of the location is spread out among all six fights. Likewise, it is not rewarding to use the Life glitch for extra experience as XP is similarly split. AoE damage is fantastic in this fight, and the Tier 2 j-items carry pretty far into the game for this boss. Very high Physical damage spots can pose some trouble to low-level parties, but an HrGlass can bring you time to recover. Cover is also solid.'
    , '### Additional Notes
The `alt:gauntlet` flag replaces the fights outlined above with five fights drawn from the area around the boss location, or one of applicable power level (e.g. the Baron Basement boss draws from the Land of Summoned Monsters, like both Feymarch boss fights).

Moon locations are great XP for the Alt Gauntlet, but also can be large time sinks or highly challenging. The Super Cannon gauntlet is very rude compared to normal bosses there, and for all fights in Lower Babil and the Tower of Zot, you''ll want to bring some source of magic damage to handle pudding type enemies.

See [Alt Gauntlets](<https://wiki.ff4fe.com/doku.php?id=alt_gauntlet>) for specifics on each location.'
    , '
{
    "Damage Types": "Physical",
    "Boss Bit": "No",
    "Trait": "Gargoyle: Reptile, Weeper: Spirit",
    "Resist": "Gargoyle: Pig, Mini, KO",
    "Weakness": "Gargoyle: Holy, Air (4x)",
    "Additional Links": "[Fighter](<https://wiki.ff4fe.com/doku.php?id=Fighter>), [Weeper](<https://wiki.ff4fe.com/doku.php?id=Weeper>), [WaterHag](<https://wiki.ff4fe.com/doku.php?id=WaterHag>), [Imp Cap.](<https://wiki.ff4fe.com/doku.php?id=Imp_Cap>), [Gargoyle](<https://wiki.ff4fe.com/doku.php?id=gargoyle>), [Alt Gauntlets](<https://wiki.ff4fe.com/doku.php?id=alt_gauntlet>)"
}'::jsonb
),

(
    'Milon', 'Milon.png','https://wiki.ff4fe.com/doku.php?id=milon'
    , '### Fight Flow
While both Milon and any Ghasts are on the field, Milon will command them to use Drain. If Milon is alone, he''ll alternate between casting single target Lit1 and using Fight. When only Ghasts are left, they''ll use Fight. Milon always reacts to damage with a Lit1 counter.'
    , '### Strats
Often you''ll approach the fight by using AoE to clear the Ghasts, and relying on one/two damage dealers to kill Milon. Only having a couple of people attacking Milon results in fewer Lit1 counters, which will generally speed things up. At high physical damage spots, Blink/Illusion takes the threat out of Milon fairly well, as would Cover.'
    , '### Additional Notes
At high physical damage spots, tossing an HrGlass to stop the Ghasts, and then focus firing down Milon can result in a very clean fight. If you do this, be very aware of how hard the Ghasts will punch if the stop effect wears off.'
    , '
{
    "Damage Types": "Milon: Physical, Lightning. Ghasts: Physical, Magic",
    "Resist": "Ghasts: Dark Immune, Poison, Blind, Mute, Pig, Mini, Frog, KO, Calcify 1, Calcify 2, Berserk, Charm, Sleep, Stun, Float, Curse",
    "Weakness": "Ghast: Fire, Holy",
    "Boss Bit": "Yes (Milon), No (Ghasts)",
    "Additional Links": "[Ghast](<https://wiki.ff4fe.com/doku.php?id=Ghast>)"
}'::jsonb
),

(
    'Milon Z.', 'MilonZ.png','https://wiki.ff4fe.com/doku.php?id=milon_z'
    , '### Fight Flow
Milon Z''s only damage comes from Fight, which can proc the Curse status effect.'
    , '### Strats
As standard for physical fights, Blink/Illusion/MoonVeil are all great defense options. Milon Z''s Undead trait means that Cure magic/potions cause harm. At low HP spots, Cure2 pots possibly do better damage than your party''s normal attacks, and a Cure3 or two can really speed up the fight. Don''t toss Elixirs.'
    , '### Additional Notes
Wizard hats, Sorcerer and White robes provide defense against Undead, as does any part of Cecil''s Paladin or Crystal defensive gear. Generally equipping any of those on a Cecil in the back row lets Cover strats carry the day. Also, the Crystal sword does extra damage against Undead, as do White arrows.'
    , '
{
    "Damage Types": "Physical",
    "Resist": "Ice Absorb",
    "Weakness": "Air, Holy, Fire",
    "Trait": "Undead",
    "Boss Bit": "Yes"
}'::jsonb
),
(
    'DKC', 'DKCecil.png','https://wiki.ff4fe.com/doku.php?id=d.knight'
    , '### Fight Flow
Dark Knight Cecil will use Dark Wave on the whole party three times, give a short speech, and then disappear. If you use Fight (Avenger/Berserk counts), the “three times” count resets.'
    , '### Strats
Sit back and accept a little damage. In places where the damage outpaces your HP, fast healing goes a long way. Cure3/Elixir can be fight-savers, and slowing the battle speed can let you get more healing in between Dark Waves. Also consider who''s going to survive a wave to target with healing so you can assure victory or maybe get another character XP. Properly anchored, Edward can hide before the first Dark Wave comes out and can earn you a free win. Finally, Jump can help evade a round of damage, since characters in the air won''t be hit by Dark Wave, and the command doesn''t count as Fight.'
    , '### Additional Notes
When `Bnofree` is on, you have to kill DKC; additionally with `Bnofree`, DKC cannot gate intended Underworld access unless `Bunsafe` is also on.'
    , '
{
    "Damage Types": "Untyped, based on Physical stat",
    "Boss Bit": "Yes"
}'::jsonb
),

(
    'Baron Guards', 'Guards.png','https://wiki.ff4fe.com/doku.php?id=guard'
    , '### Fight Flow
The Guards only Fight on their turns. They''ll react to magic cast on them with a single target Piggy, and react to Fight with a single target Size.'
    , '### Strats
Since the Guards don''t normally have the boss bit, an HrGlass, Coffin, or successful use of the Stone spell (or multiple casts of Stop) fully control the fight. Mute, or using a MuteBell, removes their ability to cast. Rune axe, Mute knife, Mute arrows, and Elven bows do extra damage, and properly timed, an Assassin dagger is just as effective as a Coffin. Should Rydia have learned Cockatrice or Mage, both of them can be very useful in the fight as well. Size and Toad also negate this fight''s threat.'
    , '### Additional Notes
Equipping a Rune ring, Ribbon, or an Aegis shield will give a character mage defense, giving great protection from a Guard''s attack. Ribbons and Crystal armor also block both status effect counters from the Guards, Zeus Gauntlets against Size, and a Ruby ring protects against Piggy.

At high XP spots, Life glitches, or even a Life2 grind, can be very welcome infusions of experience.

With `Bnofree` on, this fight becomes much more dangerous. A focus on minimizing incoming damage and handling the Size/Piggy counters will help greatly. Equip anti-Mage defensive equipment to reduce incoming damage, and give any status protection to the most important character(s) in the party for the fight. Getting Wall status on characters is also great as a form of status prevention; just make sure you have curative potions to help handle damage. If your party relies on physical damage to clear fights, equip anti-Mage weapons (Rune axe, Mute knife, Mute arrows, Elven bow) and try to only have one or two very strong attackers dealing damage. Parties that can bring Magic damage should bounce damage spells off of a Wall.'
    , '
{
    "Damage Types": "Physical",
    "Trait": "Mage",
    "Boss Bit": "No"
}'::jsonb
),

(
    'Karate', 'Yang.png','https://wiki.ff4fe.com/doku.php?id=karate'
    , '### Fight Flow
Karate alternates between using Fight and Kick. After Karate queues the second Kick, any Paladin Cecil using Fight will cause Karate to say “Ouch” and perish.'
    , '### Strats
Generally normal strategies for dealing damage and handling incoming physical attacks apply. Cover strats don''t often work to keep the whole party alive, since Kick will deal AoE damage that ignores Barrier/Blink status and can do enough to kill party members that have low HP.'
    , '### Additional Notes
`Bnofree` removes the Ouch reaction, so you''ll have to fight the fight straight up.'
    , '
{
    "Damage Types": "Physical",
    "Boss Bit": "Yes"
}'::jsonb
),
(
    'Baigan', 'Baigan.png','https://wiki.ff4fe.com/doku.php?id=Baigan'
    , '### Fight Flow
The left arm (the one closest to the party) will cycle a sequence of Fight, Entangle, Fight for its actions. The right arm will alternate between Fight and Vampire. If Baigan dies before the arms do, they''ll use Explode the next time they get to queue an action. Baigan''s script has a cycle of five consecutive Fight turns, then casts Fast on any living arms, and then does another Fight while any arms are alive. When both arms are dead, Baigan will use Recover. In reaction to a magic cast, Baigan casts a self-targeted Wall.'
    , '### Strats
Sweeping spells that also pierce Wall (e.g. Quake, Summons) are a great action, preventing the arms or Baigan from dealing damage to the party; just make sure to only queue the cast when you can see that the arms are being targeted as well. Most of the damage from the enemies is from Fight, so Blink/Illusion/MoonVeil are all very useful as ways to prevent damage. Berserk, which is so often a main strategy, is a little less powerful in this fight due to the random targeting. It''s still useful, especially as a way to keep damage flowing and helping other party members get an effective speed boost.

As the fight goes on and Baigan reflects a Wall onto your party, you can use that to bounce spells back. Timed well, you can get spells to mainly hit Baigan and not the arms. The Walls do make it more difficult to keep Blink/Illusion up on characters, or do mass heals. This is not a bad fight to dip into the Cure3 potion supply.'
    , '### Additional Notes
Making good use of Cover in this fight can be a little difficult, since Cecil can''t cover the Vampire from the Right Arm. Keeping that enemy dead is a high priority if Cover is your best defensive plan, so you might consider single/manually targeting spells and attacks. This kind of strategy is more useful at high physical attack locations where you don''t have the AoE to clear the arms, and have good physical attackers that can reach to back row enemies without penalty (Jump, Aim, Dart, characters equipped with long range weapons, or characters that have the back row glitch applied).'
    , '
{
    "Damage Types": "Physical, Magic (Right Arm - Vampire)",
    "Boss Bit": "Yes",
    "Additional Links": "[Left Arm](<https://wiki.ff4fe.com/doku.php?id=left_arm>), [Right Arm](https://wiki.ff4fe.com/doku.php?id=rightarm)"
}'::jsonb
),

(
    'Kainazzo', 'Kainazzo.png','https://wiki.ff4fe.com/doku.php?id=Kainazzo'
    , '### Fight Flow
Kainazzo begins the fight with a punch, then enters a cycle of gathering water, using Wave, and then self-targeting a Fast cast. Using Lightning based magic will cause the water to dispel, and set Kainazzo up to queue a punch on the next opportunity to queue an action. That means that if the water is dispelled before Kainazzo queues Wave there will not be a wave on that cycle, if Kainazzo does queue Wave, dispelling the water will not prevent the Wave. When damaged at low HP (17.5% of max or less), Kainazzo will retreat into the shell, dispelling any gathered water. After hiding, Kainazzo''ll use Remedy to heal, then take a single turn to both set defenses and prepare to gather water.'
    , '### Strats
This is a fight where location significantly dictates tactics. At spots where your party can''t ever reasonably survive the first Wave (often the 2nd boss on the Hook route, or the first spot in the Giant), your first turns should be working towards both setting up long term goals (getting a berserker online, getting Blink up, tossing a SilkWeb), and making sure that the water is dispelled before the Wave usage gets queued.'
    , '### Additional Notes
At high HP spots, or if your damage is low for the location, you can find yourself in a loop where the Remedy action outpaces your ability to do damage. If that''s happening while you only have berserked characters, you should probably reset and either try again to have more people up and fighting at the end, or come back after getting a few more levels.

The timing to dissipate the water before a Wave can be queued can be tricky, so slower battle speeds might be necessary. Given an RA1 setup, you can also time queuing up an item toss with the punch so that the item gets used just after the water is gathered.'
    , '
{
    "Damage Types": "Physical, Untyped Magic (Wave)",
    "Weakness": "Ice (water down), Lightning (gathered water)",
    "Boss Bit": "Yes"
}'::jsonb
),

(
    'Dark Elf', 'DElf.png','https://wiki.ff4fe.com/doku.php?id=dark_elf_post-harp'
    , '### Fight Flow
The fight begins with Dark Elf chaining together party-wide Fire2/Ice2/Lit2 attacks, then using Weak and Piggy on consecutive turns, before starting back at the top. After taking damage below a certain threshold, Dark Elf transforms to the Dark Dragon form, where the script alternates between using Fight and DBreath.'
    , '### Strats
Get some damage going (preferably with someone doing Holy damage), try to make sure any necessary Mages get healed of Piggy if they''re hit by it, and restore hit points to people who get hit by Weak. Once you transition to the dragon phase, Stop, Weak, or an HrGlass really solves the fight from there. If you don''t have access to that, just continue restoring HP, and get anyone with dragon-killing gear going with some Bersk. Casting Holy elemental spells at the Dragon form is a bad idea, since the transformation includes an addition of Holy absorb (physical attacks are still fine).'
    , '### Additional Notes
The dragon form lacks the boss bit, and while it does have some status resistances, it won''t resist Stop, an HrGlass, or the Weak spell. The fight can be really sped up with a properly timed Weak cast.'
    , '
{
    "Damage Types": "Dark Elf: Fire, Ice, Lit. Dragon form: Physical, Fire (D.Breath)",
    "Resist": "Dragon form: Holy Absorb Blind Mute Pig Mini Frog Petrify KO Calcify 1 Calcify 2 Berserk Charm Sleep Stun Float Curse",
    "Weakness": "Holy",
    "Trait": "Dragon form: Dragon",
    "Boss Bit": "Dark Elf: Yes, Dragon form: No",
    "Additional Links": "[Dragon form](<https://wiki.ff4fe.com/doku.php?id=dark_elf_dragon_form>)"
}'::jsonb
),
(
    'Magus Sisters', 'MagusSis.png','https://wiki.ff4fe.com/doku.php?id=Cindy'
    , '### Fight Flow
While Cindy is alive, Sandy will cast Wall on her and Mindy will target Cindy with a spell (cycling through Fire2, Lit2, Ice2, and Virus) intending to bounce it off of the Wall Sandy provides. Cindy''s script has her punch while both her sisters are alive. If either of her sisters are gone she''ll punch once more, and then use Remedy to revive her missing sisters.'
    , '### Strats
Quake, Meteo, and most of Rydia''s summons do pretty well here, since they all bypass the Wall that gets put on Cindy. Physical fighters generally prefer to have some sort of mage-killing weapon equipped, and be back-row glitched. Different parties might have different priorities, but if the fight is dangerous for your party, killing Cindy or Mindy first can help ease the fight along. Removing Cindy removes the possibility of Mindy/Sandy being revived, and removing Mindy reduces the magic damage coming at the party (while making Cindy no longer in a back row, so the physical damage portion of the fight does increase for a bit).

Parties with a Nuke caster can, with proper anchoring and party order, can sometimes kill Sandy first, preventing a Wall from going on Cindy, which can help make the start of the fight more manageable.'
    , '### Additional Notes
While Cindy has more HP than her sisters in the fight, each sister awards one-third of the spot''s XP, which can make the sisters a good grind. And since they have a mage weakness, there can be a leeway where it''s a reasonable mini-grind.

Lower level parties might want to avoid using berserk, since it can spread out damage too much, and leave you taking both punches from Cindy, and reflected spells from Mindy. The Dragoon armor set provides good elemental protection for those that can wear it, as does the Crystal Helm and Protect rings. Also don''t discount the Lit resistance from Diamond rings or Sorcerer robes. When you''re under leveled for the fight, making any of the spells be less dangerous is really helpful. Having a Headband for Charm resistance can also save you when Cindy''s gone and Sandy starts slinging spells at the party.'
    , '
{
    "Damage Types": "Cindy: Physical\r\nMindy: Lit, Ice, Fire, Untyped Magic",
    "Trait": "Mage",
    "Boss Bit": "Yes",
    "Additional Links": "[Sandy](<https://wiki.ff4fe.com/doku.php?id=Sandy>), [Mindy](<https://wiki.ff4fe.com/doku.php?id=Mindy>)"
}'::jsonb
),

(
    'Valvalis', 'Valvalis.png','https://wiki.ff4fe.com/doku.php?id=Valvalis'
    , '### Fight Flow
At the start of the fight, Val will assume tornado form, changing defensive values (See Tornado Defense for details, as different locations have vastly different stats). While in tornado form, Val will alternate between chaining single targets of Weak and Ray, and using Fight. If a character uses Jump (hit or miss), Val will fall out of tornado form, reset defenses and punch as a reaction, and then take a turn to use Fight again, take an empty turn and set up getting back to tornado form.'
    , '### Strats
The location really dictates some of your choices in the fight, and the fight in general is one that should guide party choices if you''re mage heavy. Generally, the fight relies on physical attacks hitting through the defenses Val spins up. Blink/Illusion are most of the defense you need in the fight, along with some ways of clearing the calcify/stone status.

In a mage heavy composition, using Jump and timing the magical onslaught will likely be the fastest/easiest way through, although swapping one character over to a bow/arrow and stacking +Str gear can be an alternative path if the Jump command is not available.'
    , '### Additional Notes
It can be a good idea to carry some extra Heal potions for this fight when you have a limited party size, to help prevent your characters from fully becoming stone. You can also kill a character before they fully turn to stone and resurrect them to clear any partial calcification.

Aim, Kick, Dark, and Dart all are able to hit Valvalis in tornado form, so you can lean on them if you don''t have the multipliers to get through the defenses and also don''t have Kain to knock Valvalis out of tornado form.

Valvalis will not gate intended Underworld access unless `Bunsafe` is on.'
    , '
{
    "Damage Types": "Physical",
    "Boss Bit": "Yes",
    "Additional Links": "[Tornado Defense](<https://docs.google.com/spreadsheets/d/1tVQFvlQ_4oWCn0EE9d7QAGrYW3w2IbZzuO2MWuUC8ww>)"
}'::jsonb
),

(
    'Calbrena', 'Calcabrina.png','https://wiki.ff4fe.com/doku.php?id=calbrena'
    , '### Fight Flow
The small dolls will all attack, unless they''re down to one type (either Cal or Brena) left, when they''ll summon Calbrena on their next action. Calbrena will Fight, use Glance, Fight on two consecutive turns, use Hold, and Fight again before restarting at the top. The Big Doll also will counter elemental Fire, Ice, or Lit magic with Fire, Wave, and Thunder, respectively. Calbrena can revert back to all the small dolls if damaged while at very low HP (2.16% of max HP) and not killed.'
    , '### Strats
Quake is fantastic against the dolls at many spots, and Meteo can be too, although you''ll eat a lot of attack animations waiting for rocks to fall. The back dolls (Cals) don''t get the boss bit, so a common tactic is to toss an HrGlass, clean up the Brenas, then finish off the stopped enemies. The main thing you mostly want to avoid in this fight is seeing Calbrena, so if you don''t have any way of Stopping the Cals, nor AoE damage to clear all of them together, you''ll want to kill off the dolls so that you can take out the last of each type at roughly the same time.'
    , '### Additional Notes
Each Cal has just under 12% of the spot''s HP, each Brena has just under 4%, and Calbrena has just over 54%.'
    , '
{
    "Damage Types": "Physical, Fire, Ice, Lightning",
    "Boss Bit": "Yes (Brena, Calbrena) No (Cal)",
    "Additional Links": "[Cal](https://wiki.ff4fe.com/doku.php?id=cal), [Brena](https://wiki.ff4fe.com/doku.php?id=brena)"
}'::jsonb
),
(
    'Golbez', 'Golbez.png','https://wiki.ff4fe.com/doku.php?id=golbez_dwarf_castle'
    , '### Fight Flow
The fight opens with Golbez casting HoldGas on the party, paralyzing them, then summoning Shadow. Shadow will use Demolish either three times, or until the party is down to two on-screen characters, whichever happens first. Golbez then dismisses Shadow, becomes vulnerable, and removes the HoldGas. Then Golbez will cycle through single-target casts of Virus, Lit3, and Fire2.

Dealing direct damage when Golbez has 19,000 HP or fewer will cause him to react with a plaintive “Why?” and then Vanish.'
    , '### Strats
If you can, take advantage of [status priorities](<https://wiki.ff4fe.com/doku.php?id=status_priority>) by using Mute, Size or Piggy before the battle when you know you''re facing Golbez. This will prevent the HoldGas from paralyzing the party, making it easy to get StarVeils up on whoever is left. You can also self-target Venom from a well-placed/anchored Black Mage for the same effect, or use the Silence staff''s item effect of a Mute cast (single or party-wide). If you lack the ability for any of that, consider getting into a random encounter and killing off all but your two most important characters for the upcoming fight, and then taking on Golbez. Alternatively, a trip to the dancer in the Mysidia inn can turn your whole party to pigs.

Characters wearing a Ribbon or Adamant armor are immune to Shadow''s Demolish, and Adamant armor, Crystal rings and Heroine robes prevent being paralyzed.

Depending on your damage output, you can sometimes just let Golbez do the damage to himself and have anyone trigger the finishing script. Cecil with a Holy weapon often speeds up finishing out the fight very quickly.'
    , '### Additional Notes
High magic spots might seem scary, but can be a great way to leverage some early XP, since Golbez will do most of the work. The Asura spot in the Feymarch, or the Ogopogo (Masamune altar) spot are two notable examples of this ''Stop Hitting Yourself'' approach. Other spots have very low magic damage, like the White Spear altar (Plague''s spot) or the top of Lower Babil (Lugae''s spot), which means that you can often just forgo using any Wall status at all.

At locations other than the first Giant boss location (the vanilla Elements fight), Golbez gets an additional 19,000 HP which generally forces the “Why?” script as the way you defeat Golbez.

Golbez will not gate intended Underworld access unless `Bunsafe` is turned on.'
    , '
{
    "Damage Types": "Lightning, Fire, Untyped Magic",
    "Weakness": "Holy, Fire",
    "Boss Bit": "Yes",
    "Additional Links": "[Shadow](<https://wiki.ff4fe.com/doku.php?id=shadow>) [Status Priority](<https://wiki.ff4fe.com/doku.php?id=status_priority>)"
}'::jsonb
),

(
    'Dr Lugae', 'Lugae.png','https://wiki.ff4fe.com/doku.php?id=dr.lugae_first'
    , '### Fight Flow
This conversation-heavy fight starts with Balnab punching the doctor, who then Heals Balnab. Each will perform their one action (Fight for Balnab and Heal for Lugae) until they are the only monster left. A lone Balnab will Fight one more time and then Explode. When alone, the doctor will transform into Balnab-Z, who Fights twice and then uses Explode.

After the first fight ends, a second begins, with another Dr. Lugae form. This fight starts with more dialog, and then Lugae transforms and uses Poison on the party, after which Lugae cycles through Beam, Laser, Emission, and then a party-wide Heal. Lugae will react with any damage the party inflicts with a single target Gas counter.'
    , '### Strats
The first fight gives you a decent bit of setup time and has fairly limited damage potential. You do want to decide early on if you think you''re able to take down both Lugae and Balnab, or if you want to focus fire on one and just accept Explode into your life. Having good AoE (Quake, Levia, Baham) should lean you towards taking out both in the first fight, where having only one strong damage source might indicate that facing Explode is a good option. Also, sometimes having someone to revive, which likely happens post-poison, is better than them being alive at the start of the fight.

Once into the second fight, lean on your big damage dealers pretty heavily. With RA1 setups, you''re unlikely to get a Bersk cast off before the Poison blocks it, so don''t count on that landing. Lugae''s Laser ability can be a major issue at high HP spots. For the most part, though, even the second fight isn''t too scary if you take your time and manage resources well.

The robot trait on both Balnab and the second Dr. Lugae means that Thunder claws do great work, and also that Cid can do some really heavy lifting in the fights.'
    , '### Additional Notes
Walls will reflect both Beam and Emission, and will block Laser, which makes it very handy at high HP spots, or if the party is underleveled. Underleveled parties should also make liberal use of Heal if the Gas counters land. Limiting how many characters are dealing damage limits the Gas counters, as well as frees up characters for opportunistic potion (Heal/Cure/Life) usage to keep the party up and going.

Relative HP breakdown (rounded to nearest percent):
Dr Lugae 1: 23%
Balnab: 21%
Balnab-Z: 21%
Dr Lugae 2: 35%'
    , '
{
    "Damage Types": "Physical, Untyped Magic, Fire",
    "Trait": "Robot (Balnamb, Dr. Luage 2)",
    "Boss Bit": "Yes",
    "Additional Links": "[Balnab](<https://wiki.ff4fe.com/doku.php?id=balnab>), [Balnab-Z](<https://wiki.ff4fe.com/doku.php?id=balnab-z>), [Lugae (2nd Fight)](<https://wiki.ff4fe.com/doku.php?id=dr.lugae_second>)"
}'::jsonb
),

(
    'Dark Imps', 'DarkImps.png','https://wiki.ff4fe.com/doku.php?id=darkimps'
    , '### Fight Flow
The Dark Imps Fight. That''s it.'
    , '### Strats
At many spots, Quake is a very effective spell since it does not have any damage split for hitting multiple enemies. Berserk is generally a great ability, but sometimes you might have a need to focus fire in order to reduce incoming damage by killing one imp ASAP. For defense, the standard Blink/Illusion/MoonVeil are always applicable for this fight.'
    , '### Additional Notes
An HrGlass, or landing a Stone, Size or Toad spell will win (or effectively win) the fight with the Dark Imps while `Bnofree` is off. Since Size and Toad do persist when Life2 is used, when the fight is at high XP spots (Ribbon room or either Giant location especially) you can do an extended, D.Machin-like grind if you have access to those spells.

If `Bnofree` is enabled, Cover strats can become one of the best helpers for the fight when your party is underleveled.'
    , '
{
    "Damage Types": "Physical",
    "Boss Bit": "No"
}'::jsonb
),
(
    'K/Q Eblan', 'Eblan.png','https://wiki.ff4fe.com/doku.php?id=k.eblan'
    , '### Fight Flow
K.Eblan will cast Fire 2 three times before switching the music and then using Vanish. Q.Eblan will cast Fire1 until alone, and then queues Vanish once the King is gone.'
    , '### Strats
Wait out the damage from the spells, healing if necessary, and watch them disappear.'
    , '### Additional Notes
Since the Queen will disappear after the King does, you can sometimes speed up the fight by killing the King first. If `Bnofree` is on you must kill both, and they''ll skip their initial dialog at the beginning of the fight, which can be a handy tell in a mystery seed.'
    , '
{
    "Damage Types": "Fire",
    "Boss Bit": "Yes",
    "Additional Links": "[Q Eblan](<https://wiki.ff4fe.com/doku.php?id=q.eblan>)"
}'::jsonb
),

(
    'Rubicant', 'Rubicante.png','https://wiki.ff4fe.com/doku.php?id=rubicant'
    , '### Fight Flow
Rubicant cycles through actions of cloak opening (which gives an Ice weakness), casting Glare, closing the cloak (changing the ice weakness to an ice absorb), and then alternating between a single punch or a double punch. The first cycle will be a single punch, the second a double, then back to single etc.

Rubicant reacts to Fight with a party-wide Fire2 counter. When below 4% of the spot''s health and is hit with Fight, instead of that Fire2 counter Rubicant''ll give a small speech and disappear. Using fire magic causes a Life1 reaction targeting the whole party.'
    , '### Strats
Equipping melee characters with ice weapons (IceBrand, Ice claw, Blizzard spear, Ice arrows, etc) will hit a script-induced 4x weakness throughout the fight once Rubi''s cloak opens the first time. Depending on the spot''s magic power and your party''s HP/amount of Fire resistance gear equipped, you might opt to just use berserk on a physical fighter equipped with an ice weapon and either tank or heal through the counters, or you can make use of the Fight alternatives (Power, Jump, Aim) in order to not draw the counters.

Casters should generally lean towards using fast spells, like Virus, Quake, and Nuke most of the fight, but timing Ice3 to land when the cloak is open is definitely a skill to learn. Boreas and Blizzard items are great to toss and land while the cloak is open, especially with high HP characters who might not have ice element weapons equipped.'
    , '### Additional Notes
Rubicant generally uses single-target damage, so underleveled parties can look to strategies that don''t involve the Fight command, and making liberal use of Life spells/potions and Blink/Illusion to keep party members up and active, and generally not risking a wipe. This strategy takes more time to execute, but if you''re in a low level situation they can get you through a fight that''d otherwise not be possible to win.'
    , '
{
    "Damage Types": "Physical, Fire (Glare, Fire2)",
    "Resist": "Fire Absorb (until first cloak opening), Berserk, Ice Absorb (cloak closed)",
    "Weakness": "Ice (4x, cloak open)",
    "Boss Bit": "Yes"
}'::jsonb
),

(
    'Evil Wall', 'EvilWall.png','https://wiki.ff4fe.com/doku.php?id=EvilWall'
    , '### Fight Flow
EvilWall will punch 16 times, then switch to using Crush. Since the punching phase uses chained commands to keep the “advance, punch” combination together, EvilWall effectively acts as though it''s berserked during this phase. No ATB cheating shenanigans happen during the Crush phase.

EvilWall will counter any magic usage affecting it with a Petrify counter, so mage heavy compositions can run into some trouble with the Stone condition if they''re reliant on low damage spells. Call and Twin do not trigger that reaction.'
    , '### Strats
Berserk status does wonders for helping mitigate EvilWall''s ATB shenanigans. Some parties might prefer using a fast agility anchor as a different mitigation strategy, and a SilkWeb can provide some solid additional benefit. Good defensive gear and using the backrow glitch will help keep party members alive, and using Blink/Illusion helps a lot too. With a MoonVeil and Crush protection, one character can be immune from any of EvilWall''s actions.'
    , '### Additional Notes
EvilWall will punch itself if there are no valid PC targets to hit. In some places you can use this along with Edward''s Hide command to let EvilWall kill itself, or with the aid of a Ribbon or Adamant armor to prevent the instant death effect from Crush, let Edward come out of hiding once the fight is in Crush phase to finish the job.'
    , '
{
    "Damage Types": "Physical",
    "Boss Bit": "Yes",
    "Additional Links": "[Eddy Vs EvilWall](<https://docs.google.com/spreadsheets/d/1TQY6hGjqkC1NQGDv_M0pzPQa2xZZlAT7rzCzCNLyX1g>)"
}'::jsonb
),
(
    'Elements', 'Fiends.png','https://wiki.ff4fe.com/doku.php?id=elements_milon_rubi'
    , '### Fight Flow
The Milon form will Fight on four consecutive turns, and then use Curse. Rubicant will cycle through Fire2, Fire3, and Glare. Kainazzo uses Fight four consecutive turns, then uses Big Wave. Valvalis alternates between Fight and Ray for two instances each, then one sequence of Fight and Storm. Each boss has an HP threshold where they''ll use their reaction to transform into the next form in the cycle.'
    , '### Strats
Generally, this is a straightforward damage trait, with Rubicant''s Fire3 and Glare casts being the main concern. Take advantage of elemental (or racial) weaknesses where you can to speed up the fight and reduce the threat of the encounter.

Often the fastest path through is to reflect spells onto the Milon form and never see any other of the Fiends. Placing the Wall on someone with Undead protection (a Wizard hat, Sorcerer robe, or a part of Cecil''s Crystal armor set are common ways of getting this) means that Milon''s attacks will deal reduced damage to that character, making healing them often not required. Another quick way through the fight is to target Rubicant''s defenses. Edge with Mute knife and a decent katana, or an archer with Ice arrows and an Elven bow can generally skip over the Kainazzo/Valvalis portion of the fight.'
    , '### Additional Notes
Since this fight is actually two separate HP pools (Milon/Rubi in one, Kainazzo/Val in another), if you can kill the first fight without hitting the HP threshold for it to transform into the other, you''ll never face the Kainazzo/Valvalis fight. Typically this happens with using a Wall and bouncing spells onto the Milon form. Since reflected spells don''t trigger reactions, you''ll never see any other shape.

The Milon Z and Kainazzo forms both use a Chain to set their resists/weakness/trait values as their first turns. Milon Z''s defenses can be a little confusing because of the combination of a Holy absorb and setting the Undead trait. The Undead trait allows dealing damage with Cure spells and White, while Meteo still gets absorbed.'
    , '
{
    "Damage Types": "Milon: Physical, Rubicant: Fire, Kainazzo: Physical, Untyped Magic (Big Wave), Valvalis: Physical",
    "Resist": "Milon: Absorbs: Ice, Holy*, Dark, Lightning, Air, Rubicant: Absorbs: Fire, Holy, Dark, Lightning, Air, Kainazzo: Absorbs: Fire, Ice, Dark, Holy, Air, Valvalis: None",
    "Weakness": "Milon: Fire (4x), Rubicant: Ice (4x), Kainazzo: Thunder (4x), Valvalis: Thunder (4x), Holy (4x)",
    "Trait": "Milon: Undead, Rubicant: Mage",
    "Boss Bit": "Yes",
    "Additional Links": "[Kainazzo/Val](<https://wiki.ff4fe.com/doku.php?id=elements_kainazzo_val>)"
}'::jsonb
),

(
    'CPU', 'CU.png','https://wiki.ff4fe.com/doku.php?id=CPU'
    , '### Fight Flow
The Attacker always uses Maser, which deals 10% of each target''s HP in damage. The Defender always uses Remedy on the CPU, which heals it for 10% of the CPU''s total health. The CPU will cast Wall when it doesn''t have a Wall up. If both the Attacker and Defender are dead, the CPU will use Globe 199 twice, then resurrect the Attacker and Defender.'
    , '### Strats
Most strategies start with killing the Defender, since it can be extremely hard to keep up with the healing that it does. Teams with Jump, Aim, Dart, and backrow-glitched characters will be able to attack the CPU at full damage, and often rely on manual targeting to avoid having to deal with Globe 199 and resurrected Attacker/Defender nodes. Berserk and Blink can be, RNG willing, a good pairing when the berserk is used on just one party member and you can quickly (re)apply Blink on the Attacker node. And once enough damage has been dealt, going all in on damage (e.g. stop using Blink, berserk more, use Meteo/Quake) can help shorten the time it takes to get through this fight. Setting up Nuke/White casters with a Wall on a party member and letting them be part of the barrage is also a good play.

Float strats, where you get a Wall up on one character and try to reflect the Float on the Attacker orb, can also be very helpful as long as the Float doesn''t reflect back on the CPU. Quake can be safely cast once Float is on the Attacker, and Black Mages can get in on the damage party without reflecting single target spells and hoping they land on CPU.'
    , '### Additional Notes
The Attacker and Defender each get 10% of the spot''s HP, but award one-third of the spot''s XP. With a combination of location and team composition, you can set up a pretty effective grind by forcing resummons of the orbs, but you''ll also have two Globe 199s per cycle, so Life potions/spells, especially Life2, and party-wide healing will be important for an orb grind.'
    , '
{
    "Damage Types": "Untyped Magic",
    "Boss Bit": "Yes",
    "Additional Links": "[Attacker](<https://wiki.ff4fe.com/doku.php?id=Attacker>), [Defender](<https://wiki.ff4fe.com/doku.php?id=Defender>)"
}'::jsonb
),

(
    'Odin', 'Odin.png','https://wiki.ff4fe.com/doku.php?id=odin'
    , '### Fight Flow
Odin will use Fight three times, then raise his sword and take an empty turn, then use Odin (a party-wide attack). He''ll then Fight twice, then raise his sword, take an empty turn, then use Odin. Then he''ll Fight once, start a chain to raise his sword and set a flag to allow Thunderstruck, then unset the flag while queueing Odin. Repeat from the top if both sides are alive.'
    , '### Strats
Getting a berserker going early is a strong start to the fight. The Lightning weakness makes Thunder claw users really shine, and Lit arrows do well too. Defensively, Blink/Illusion will help you handle the physical attacks. Many combinations of the fight location and party composition make you trait to kill Odin before the first Odin attack comes out.

In order to get a ''Thunder struck Odin!'' kill, you need to deal non-physical Lightning damage in the small window available between the third time the sword is raised and when the Odin attack is queued. Both Hide and Jump help get a character off-screen during an Odin swipe, and Blink or a MoonVeil will protect against any punches that would have to be absorbed in order to correctly time the Thunderstruck attempt. The window to land the Lightning damage is so small that you generally need an RA2 or slower Odin and have to react to the punch, not the sword raise for a successful attempt.'
    , '### Additional Notes
`Bnofree` has no effect on Odin''s script.'
    , '
{
    "Damage Types": "Physical, Untyped Magic",
    "Weakness": "Lightning (4x)",
    "Boss Bit": "Yes"
}'::jsonb
),
(
    'Asura', 'Asura.png','https://wiki.ff4fe.com/doku.php?id=Asura'
    , '### Fight Flow
On each of Asura''s turns, Asura will self-target a spell based on the current active face, and whether or not a reaction script was triggered in between Asura''s turns. If a reaction was triggered, no face cycling occurs. If not, she''ll cycle to the next face before casting. The orange face casts Cure4, the cream face casts Cure3, and the gray face casts Life1. When rotating the active face, the rotation goes orange => cream => gray => orange.

When Asura is dealt damage, the face rotation is reversed, so you''ll see the faces go from orange => gray => cream => orange. If you deal damage to Asura and the active face doesn''t change from where it was before the damage was dealt, that means Asura just queued the spell that corresponds with that face.'
    , '### Strats
Asura never attacks your party except as a reaction, so you have plenty of setup time to get Blink/Illusion/MoonVeil on party members before actually being attacked. 

Giving Asura the Reflect status will bounce those self-targeted spells, which then means this becomes like fights that just have physical attacks to deal with. Because those physical attacks come from a reaction to direct damage, if the location''s damage is deadly to your party, you''ll often want to have a single source of damage throughout the fight. And even if the damage isn''t high, if your party is doing lots of low damage attacks, you''ll spend a lot of time in animations in battle that aren''t necessary. Edge with a Mute knife and a decent katana is great in this fight, as is anyone swinging a Rune Axe. For bows and arrows, both Mute arrows and the Elven bow hit the Mage trait, so mix/match your best combination for maximum damage. Defensively, equipping a Ribbon, Rune ring, or Aegis shield gives protection from Mages, reducing the threat of Asura''s counters.

Parties without much physical firepower will prefer bouncing spells off of a Wall to both be able to cast Virus/Nuke during the fight, and also not require any healing/preventative measures.

Lastly, the Lifelock strategy of keeping Asura on continually casting Life1 is something generally best used in the overworld. Using quick actions (Fight, Virus, Nuke, damaging j-items, Dancing Dagger, etc) just as the Life1 is cast from Asura will cycle back to that face and cast Life1 on when acting next. Depending on party speed, you might have to have every member contribute with some damage, so inaccurate characters will want to rely on item usage to do their part. This strategy is not something to do when Asura is at fast RA numbers (RA1, probably RA2 as well), since you might lose the correct ATB timing to have Asura remain on the correct face.'
    , '### Additional Notes
When Cure4 would heal between 16,384 and 32,767 HP it actually will heal for nothing regardless of the amount displayed on screen. See the [wiki](<https://wiki.ff4fe.com/doku.php?id=bugs#asura_cure4_bug>) for other scenarios and more detail.'
    , '
{
    "Damage Types": "Physical",
    "Trait": "Mage",
    "Boss Bit": "Yes"
}'::jsonb
),

(
    'Leviatan', 'Leviath.png','https://wiki.ff4fe.com/doku.php?id=leviatan'
    , '### Fight Flow
Leviatan goes through a cycle of chaining together changing form and using Big Wave, then taking a turn to change form back. After that, Leviatan casts Ice 2 either twice (odd times through the cycle) or once (even times through the cycle), and then takes an empty turn. That empty turn gets eaten into a bit since the chained actions come right after.'
    , '### Strats
This fight is generally not much to worry about if you have decent healing. Zerkers are happy to zerk, Black Mages can cast the standard array of spells (best of Virus, Quake, Nuke) or also choose to add in their Lit spells. At high magic locations those Ice2s can really hurt, so using a StarVeil is definitely a solid choice to help get through a fight.'
    , '### Additional Notes
The Lightning weakness being 2x means that Yang''ll get a bigger increase over Edge in equipping a Thunder claw. If you have both on your team, the other equipment will decide who should get it. Edge with pretty mismatched katanas, think Masa/Long or Ninja/Short, will be very happy to replace the weaker blade with a Thunder claw.'
    , '
{
    "Damage Types": "Untyped Magic, Ice",
    "Weakness": "Lightning",
    "Boss Bit": "Yes"
}'::jsonb
),

(
    'Bahamut', 'Bahamut.png','https://wiki.ff4fe.com/doku.php?id=bahamut'
    , '### Fight Flow
Bahamut takes turns counting down from 5 to 1, and casts MegaNuke on the next turn. Repeat from the top.'
    , '### Strats
Methods of handling range from an all out assault, often using the berserk status, to patiently reflecting all the MegaNuke damage back at Bahamut, with a large range of a hybrid approach in-between. When the party is underleveled, you''re more likely going to be successful with reflecting MegaNuke as most of your damage. A small delay in applying Wall and using RA1 agility anchoring can make StarVeils last for up to three cycles. It can also be a great idea to stagger out the Veil usage by not protecting some characters and having them be revived by those with protection.'
    , '### Additional Notes
You get less time in between the 1 count and the casting of MegaNuke because Bahamut chains together sprite animations and the spell cast all as one turn.'
    , '
{
    "Damage Types": "Untyped Magic",
    "Boss Bit": "Yes"
}'::jsonb
),
(
    'Pale Dim', 'PaleDim.png','https://wiki.ff4fe.com/doku.php?id=pale_dim'
    , '### Fight Flow
On its turn, Pale Dim only Fights. In reaction to Fight, Pale Dim will cast Slow. In reaction to Fire magic, Pale Dim uses Glare. In reaction to Ice magic, Pale Dim uses Blizzard. In reaction to LIghtning magic, Pale Dim uses Blitz. In reaction to the Call ability, Pale Dim uses Quake.'
    , '### Strats
Another fight where Blink/Illusion/MoonVeil do so much to protect the party. The Slow counters from Pale Dim can vary from being a nuisance to something that makes the fight a little risky if you fall behind in preventative measures. Black Mages should use untyped magic (Virus, Quake, Nuke) here to avoid both healing Pale Dim and suffering the counter attack. Zerkers are fine, but if you have someone equipped with dragon killing gear (Dragoon spear, Dragon whip, Artemis arrows), you''ll want to lean on them as possibly the only attacker.'
    , '### Additional Notes
Cecil as a Cover bot can be extremely strong for this fight and be essentially invulnerable when placed in the backrow and given a Crystal ring or any Dragoon defensive gear to pick up dragon defense. Glass headgear and Adamant armor also do wonders.

Call fans rejoice at having Float status, since that nullifies the Quake counter.'
    , '
{
    "Damage Types": "Physical, Reactions: Fire, Ice, Lightning, or Untyped Magic",
    "Trait": "Dragon",
    "Resist": "Absorbs: Fire, Ice, Lightning, Poison Blind Mute Pig Mini Frog Petrify KO Sleep Stun",
    "Boss Bit": "Yes"
}'::jsonb
),

(
    'Wyvern', 'Wyvern.png','https://wiki.ff4fe.com/doku.php?id=wyvern'
    , '### Fight Flow
Wyvern begins the fight with MegaNuke, takes two consecutive empty turns, then casts a self-targeted Wall. While the Wall is active, Wyvern will bounce Nuke off of the Wall. When the Wall runs out, Wyvern will use Remedy, then re-cast the Wall, then resume the Nuke barrage.'
    , '### Strats
Wyvern''s opening MegaNuke often requires agility setups that let you get Wall status up right away. Slowing down the battle speed can allow you the time to input the commands to get Wall going; very practiced runners can substitute Battle Speed adjustments with run buffering. Early in the game you can still often outspeed the MegaNuke with fast characters anchoring the battle, but later on you''ll generally want a slow anchor and fast first actors in order to have a solid setup.

Once you''ve managed to survive the opening salvo, get people back up and let the damage fly. Dragon-killing weapons are greatly desired here to speed up the fight and reduce resource usage. After that first salvo, and assuming you don''t use Call to target Wyvern, Wyvern will only kill one person a turn, so there''s a good opportunity that you can use Life potions or spells to keep on even-ish footing.'
    , '### Additional Notes
Rydia''s Call abilities will cause Wyvern to Counter with MegaNuke (at a reduced spell power from the opening MegaNuke). Sylph is a great fast-casting Call to help reflect more MegaNuke damage back at Wyvern.

Wyvern will not gate intended Underworld access unless `Bunsafe` is on. The `whyburn` flag jumps straight to the Wall cast, skipping the MegaNuke and empty turns after it at the start of the fight. The `whichburn` flag changes the opening attack to another random enemy attack, with some protections to keep the opener milder than MegaNuke; `Bunsafe` removes those protections.'
    , '
{
    "Damage Types": "Untyped Magic",
    "Trait": "Dragon",
    "Boss Bit": "Yes"
}'::jsonb
),

(
    'Plague', 'Plague.png','https://wiki.ff4fe.com/doku.php?id=plague'
    , '### Fight Flow
While any living, on-screen character lacks Count status, Plague will cast Count on the party, which also resets the counter on everyone hit by it. Otherwise, Plague casts Fast on the party.'
    , '### Strats
Plague''s flying status means that spears, boomerangs, and bows/arrows deal extra damage, and makes Quake completely ineffective. In the Milon Z location (Back Attack on Mt. Ordeals) location, you might consider starting the fight with a party member Swooned so that you can easily reset the counter. It''s also strongly recommended you use as slow an agility anchor as possible, since you start the fight at significant ATB disadvantage from the forced Back Attack.

The Count status can be manipulated in a couple of ways. For one, Swooning and resurrecting a character will trigger Plague to re-apply the status on all party members, which resets everyone''s counter to 10, buying you more time (functionally unlimited, as long as your Life potions hold out). Alternatively, because of how the game handles conditions, using berserk, fast spells, holding A, or a combination thereof, you can make it so the character''s action prevents a count timer at 00 from resolving.'
    , '### Additional Notes
Plague is susceptible to Count, which means that reflecting it back and having the counter expire can be an efficient way to handle this fight. Generally you''ll need to use a Wall on one character, Swoon another, use Life on the Swooned character, let the Count reflect back on plague, either Swooning or letting the Walled character''s Count timer expire, resurrecting them, and waiting for the Count (which isn''t visible) to reach 00 for Plague, and then taking any action. Plague will not die to Count while at RA1 (or if enough actions are happening that makes Plague effectively function at that speed), so you might need to use Slow/SilkWeb to slow Plague to RA2. Reflected Fasts can require extra applications of Slow.'
    , '
{
    "Resist": "Poison Blind Mute Pig Mini Frog Charm Sleep Stun",
    "Weakness": "Air",
    "Boss Bit": "Yes"
}'::jsonb
),
(
    'D.Lunars', 'LunarD.png','https://wiki.ff4fe.com/doku.php?id=d._lunar'
    , '### Fight Flow
The D.Lunar''s basic script is for each dragon to use Fight, then Fire, then Fight on four consecutive turns, then use Breath, then repeat the cycle. 

If a character uses Fight against them, the attacked monster reacts by casting Wall on both of them, and their script changes to have their only action be to target a Virus on the other D.Lunar, to reflect the spell back on the party.

If there is only one D.Lunar left, it will react to everything with a Fire counter.

D.Lunars counter Call with Remedy.'
    , '### Strats
Using Fight alternatives (Power, Jump, Aim, Dart) for melee-heavy parties is standard practice. For parties with heavy magic damage, Fire3, Nuke, and Quake are good spells to use. White Mages can use Cure3 or Cure4 to good effect on the D.Lunars. Blink/Illusion are great for preventative damage, although some recovery is good to have on hand for the Fire casts. Cure3 potions can also be a good move, especially early.

At many locations, using berserk status can be a highly RNG dependent strategy, even when wielding a Crystal sword or Dragon-killing weaponry. Before applying the angry juice, consider your party''s ability to supplement that damage, or perhaps only berserk after some other foundational non-Fight damage has been applied; you''re looking to reduce the amount of Virus or Flame damage directed your way to a survivable amount. Dragoon Spears, Artemis Arrows, and the Dragon whip also can change the calculation, although do so to a lesser degree.'
    , '### Additional Notes
Low level parties (and in locations with either high Magic attack, high HP, or both) will consider Walls to reflect the Breath spell back on the enemies. A D.Lunar who has been hit by the Breath cannot use magic, will do at most 1 point of damage with physical attacks, and suffers great defensive penalties. Should the reflected Breath only attack one of the D.Lunars, you can still take great advantage of Frog Strats by Fighting the frog, since the attacked enemy is the one that uses the Wall reaction. After that initial triggering of the Virus script, any focus fire should be done to the non-frog enemy first.'
    , '
{
    "Damage Types": "Physical, Fire Magic",
    "Trait": "Dragon, Undead",
    "Boss Bit": "Yes"
}'::jsonb
),

(
    ' Ogopogo', 'Ogopogo.png','https://wiki.ff4fe.com/doku.php?id=ogopogo'
    , '### Fight Flow
The fight begins with two Big Waves chained together, taking away 50% of the party''s max HP right away. Ogopogo will then Fight on three consecutive turns, use Big Wave a single time, and then fight on two more turns, and then returns to the beginning of the fight (the double Big Wave).

Ogopogo will counter most uses of magic and all Calls with Blaze, a Ice-based attack that deals 20% Max HP damage to the party. The exception is Lightning-based magic, which elicits a single-target Weak cast. Twin causes no reactions.'
    , '### Strats
The counters Ogopogo uses means that most strategies lean heavily on berserked characters. Mages should look to bouncing spells off of a Wall, and Rydia generally will avoid using the Call ability. Blink/Illusion is important to get going early, but you will need some healing as well if the fight goes long enough that the script rolls back around to the start of the script. You''ll also want to keep an idea of where the fight is in the script if you are thinking of using non-Life2 resurrection, since a Big Wave is almost certain to render Life1/Life potions useless, unless you''ve timed other healing on the target.'
    , '### Additional Notes
This is an extremely rude boss to see at either Hook location, due to how limited your preventative/healing resources are early on, and the HP based damage is difficult to outlevel. Definitely a boss where underleveled parties very much want to manipulate agility, and slow down the battle speed.'
    , '
{
    "Damage Types": "Physical, Untyped Magic (Big Wave), Ice Magic (Blaze)",
    "Boss Bit": "Yes"
}'::jsonb
),

(
    'Zeromus', 'Zeromus.png','https://wiki.ff4fe.com/doku.php?id='
    , '### Fight Flow
The fight begins with Zeromus untransformed, invulnerable, and the only action taken is to remove speed modifiers and most statuses from the party.

After the Crystal is used, Z''s first actions are to remove the invulnerability, shake, and use Big Bang. Zeromus then goes through a cycle of visible actions: Shake, Big Bang, Black Hole, Shake, Big Bang, Virus, Black Hole, Shake, Big Bang, Black Hole, until the party does enough damage to push into Nuke Phase. Zeromus will refill HP and the cycle changes to Shake, Big Bang, Black Hole, Nuke, Shake, Big Bang. Both of these phases have extra “Do Nothing” turns not listed here. After enough damage is dealt, Zeromus switches to alternating between using Meteo and a “Do Nothing” turn.

See [Script Detail](<https://wiki.ff4fe.com/doku.php?id=zeromus_script>) for a full breakdown of all actions, as well as all the reactions and triggers in the fight.'
    , '### Strats
There are a few main strategies for handling this fight: zerkers, reflect, hybrid, Edward strats, Fu and Friends, and 1200 strats.

Zerker strats rely on getting berserk up on your physical fighters, and letting their damage carry the fight. White Mages heal, revive, or cast zerk, and Black Mages might either nerf incoming Big Bangs, bounce a spell off of a Wall (which they probably set up on themselves), or play chemist while they''re alive.

Reflect strats have the first character post-Crystal-toss Wall themselves, and then the spell casters bounce their fast damage spells off of that Wall. Either a SilkWeb or a direct cast of something (not White) as soon as Z is vulnerable will nerf the first Big Bang, which is often essential to make sure that the party survives the first Big Bang. If any physical fighters chip in, make sure that they don''t do any damage to Zeromus that puts your total damage at or above 45k, since that triggers the refill script.

Fu and Friends, Edward and 1200 Strats are all variants relying on the same tactic: getting Wall up on necessary party members, and using J-items, direct cast spells, or the Crystal to trigger Zeromus'' counter Nuke to bounce off of a Wall and reflect back. All of these strategies will stop dealing direct damage at/before 45k total damage to prevent the refill.'
    , '### Additional Notes
See the links below for some videos.'
    , '
{
    "Damage Types": "Magic (Untyped, Holy)",
    "Additional Links": "[Script Detail](<https://wiki.ff4fe.com/doku.php?id=zeromus_script>), [Edward Strats](<https://docs.google.com/document/d/1Xw1vsN-OROShv4ZxPcStwJ1LsmFlPcZr3IIjOBSNEww/edit#heading=h.dvcyslrwgp71>), [Full party 1200 strats](<https://www.twitch.tv/videos/1051386268>), [2 character 1200 strats](<https://www.twitch.tv/videos/1051391891>)",
    "Boss Bit": "Yes"
}'::jsonb
);

