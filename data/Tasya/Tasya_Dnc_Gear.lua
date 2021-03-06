-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
  state.OffenseMode:options('Normal', 'SomeAcc', 'Acc', 'FullAcc', 'Fodder')
  state.HybridMode:options('Normal', 'DTLite', 'PDT', 'MDT')
  state.WeaponskillMode:options('Match', 'Normal', 'SomeAcc', 'Acc', 'FullAcc', 'Fodder', 'Proc')
	state.IdleMode:options('Normal', 'Sphere')
  state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
  state.Weapons:options('Aeneas/Sari', 'Aeneas/Odium', 'Aeneas/Blurred', 'Aeneas/Centovente', 'Dual Malevolence')
  state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None', 'Suppa', 'DWEarrings', 'DWMax'}

	gear.stp_jse_back = {name="Senuna's Mantle", augments={'DEX+20', 'Accuracy+20 Attack+20', '"Store TP"+10'}}
	gear.wsd_jse_back = {name="Senuna's Mantle", augments={'DEX+20', 'Accuracy+20 Attack+20', 'Weapon skill damage +10%'}}

  -- Additional local binds
  send_command('bind @` gs c step')
	send_command('bind ^!@` gs c toggle usealtstep')
	send_command('bind ^@` gs c cycle mainstep')
	send_command('bind !@` gs c cycle altstep')
  send_command('bind ^` input /ja "Saber Dance" <me>')
  send_command('bind !` input /ja "Fan Dance" <me>')
	send_command('bind ^\\\\ input /ja "Chocobo Jig II" <me>')
	send_command('bind !\\\\ input /ja "Spectral Jig" <me>')
	send_command('bind !backspace input /ja "Reverse Flourish" <me>')
	send_command('bind ^backspace input /ja "No Foot Rise" <me>')
	send_command('bind %~` gs c cycle SkillchainMode')

  select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()

  --------------------------------------
  -- Sets required by rules
  --------------------------------------

	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})

  -- Extra Melee sets.  Apply these on top of melee sets.
	sets.Suppa = {ear1="Suppanomimi", ear2="Sherida Earring"}
	sets.DWEarrings = {ear1="Dudgeon Earring", ear2="Heartseeker Earring"}
	sets.DWMax = {ear1="Dudgeon Earring", ear2="Heartseeker Earring", body=gear.AdhemarJacketPlus1.B, hands="Floral Gauntlets", waist="Shetal Stone"}

  sets.Skillchain = {} --hands="Charis Bangles +2"
  sets.Kiting = {feet="Skadi's Jambeaux +1"}
  sets.ExtraRegen = {}

  --------------------------------------
  -- Base sets
  --------------------------------------

  sets.Enmity = {
    ammo="Paeapua",
    head="Genmei Kabuto", neck="Unmoving Collar +1", ear1="Friomisi Earring", ear2="Trux Earring",
    body="Emet Harness +1", hands=gear.herculean_dt_hands, ring1="Petrov Ring", ring2="Vengeful Ring",
    back="Solemnity Cape", waist="Goading Belt", legs=gear.herculean_dt_legs, feet=gear.herculean_dt_feet}

	--------------------------------------
	-- Idle
	--------------------------------------

  sets.idle = {
    ammo="Staunch Tathlum +1",
    head="Dampening Tam", neck="Loricate Torque +1", ear1="Etiolation Earring", ear2="Sanare Earring",
    body="Meghanada Cuirie +2", hands=gear.herculean_dt_hands, ring1="Defending Ring", ring2="Sheltered Ring",
    back="Moonlight Cape", waist="Flume Belt +1", legs=gear.herculean_dt_legs, feet=gear.herculean_dt_feet}

  sets.idle.Sphere = set_combine(sets.idle, {body="Mekosuchinae Harness"})

  --------------------------------------
  -- Defense
  --------------------------------------

  sets.defense.PDT = {
    ammo="Staunch Tathlum +1",
    head="Dampening Tam", neck="Loricate Torque +1", ear1="Etiolation Earring", ear2="Sanare Earring",
    body="Meghanada Cuirie +2", hands=gear.herculean_dt_hands, ring1="Defending Ring", ring2=gear.DarkRing.PDT,
    back="Shadow Mantle", waist="Flume Belt +1", legs=gear.herculean_dt_legs, feet=gear.herculean_dt_feet}

  sets.defense.MDT = {
    ammo="Staunch Tathlum +1",
    head="Dampening Tam", neck="Loricate Torque +1", ear1="Etiolation Earring", ear2="Sanare Earring",
    body="Meghanada Cuirie +2", hands="Floral Gauntlets", ring1="Defending Ring", ring2=gear.DarkRing.PDT,
    back="Engulfer Cape +1", waist="Engraved Belt", legs=gear.herculean_dt_legs, feet="Ahosi Leggings"}

	sets.defense.MEVA = {
    ammo="Staunch Tathlum +1",
		head=gear.herculean_fc_head, neck="Warder's Charm +1", ear1="Etiolation Earring", ear2="Sanare Earring",
		body=gear.AdhemarJacketPlus1.B, hands="Leyline Gloves", ring1="Vengeful Ring", ring2="Purity Ring",
		back="Mujin Mantle", waist="Engraved Belt", legs="Meghanada Chausses +2", feet="Ahosi Leggings"}

  --------------------------------------
  -- Resting
  --------------------------------------

  sets.resting = {}

  --------------------------------------
  -- Weapons
  --------------------------------------

	sets.weapons['Aeneas/Sari']= {main="Aeneas", sub=gear.TamingSari.High}
	sets.weapons['Aeneas/Odium'] = {main="Aeneas", sub="Odium"}
	sets.weapons['Aeneas/Blurred'] = {main="Aeneas", sub="Blurred Knife +1"}
	sets.weapons['Aeneas/Centovente'] = {main="Aeneas", sub="Centovente"}
	sets.weapons['Dual Malevolence'] = {main=gear.Malevolence.Max, sub=gear.Malevolence.High}

  --------------------------------------
  -- Engaged
  --------------------------------------

  -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
  -- sets if more refined versions aren't defined.
  -- If you create a set with both offense and defense modes, the offense mode should be first.
  -- EG: sets.engaged.Dagger.Accuracy.Evasion

  sets.engaged = {
    ammo="Yamarang",
    head="Dampening Tam", neck="Anu Torque", ear1="Brutal Earring", ear2="Sherida Earring",
    body=gear.AdhemarJacketPlus1.B, hands=gear.AdhemarWristbandsPlus1.B, ring1="Petrov Ring", ring2="Epona's Ring",
    back=gear.stp_jse_back, waist="Windbuffet Belt +1", legs="Samnuha Tights", feet=gear.herculean_ta_feet}

  sets.engaged.SomeAcc = {
    ammo="Yamarang",
    head="Dampening Tam", neck="Combatant's Torque", ear1="Brutal Earring", ear2="Sherida Earring",
    body=gear.AdhemarJacketPlus1.B, hands=gear.AdhemarWristbandsPlus1.B, ring1="Petrov Ring", ring2="Epona's Ring",
    back=gear.stp_jse_back, waist="Windbuffet Belt +1", legs="Samnuha Tights", feet=gear.herculean_ta_feet}

  sets.engaged.Acc = {
    ammo="Yamarang",
    head="Dampening Tam", neck="Combatant's Torque", ear1="Telos Earring", ear2="Sherida Earring",
    body="Mummu Jacket +2", hands="Floral Gauntlets", ring1="Ilabrat Ring", ring2="Regal Ring",
    back=gear.stp_jse_back, waist="Reiki Yotai", legs="Meghanada Chausses +2", feet=gear.herculean_acc_feet}

  sets.engaged.FullAcc = {
    ammo="Falcon Eye",
    head="Dampening Tam", neck="Combatant's Torque", ear1="Telos Earring", ear2="Digni. Earring",
    body="Mummu Jacket +2", hands=gear.AdhemarWristbandsPlus1.B, ring1="Ramuh Ring +1", ring2="Ramuh Ring +1",
    back=gear.stp_jse_back, waist="Olseni Belt", legs="Meghanada Chausses +2", feet=gear.herculean_acc_feet}

  sets.engaged.Fodder = {
    ammo="Yamarang",
    head="Dampening Tam", neck="Ainia Collar", ear1="Brutal Earring", ear2="Sherida Earring",
    body=gear.AdhemarJacketPlus1.B, hands=gear.AdhemarWristbandsPlus1.B, ring1="Petrov Ring", ring2="Epona's Ring",
    back=gear.stp_jse_back, waist="Windbuffet Belt +1", legs="Samnuha Tights", feet=gear.herculean_ta_feet}

  sets.engaged.DTLite = {
    ammo="Yamarang",
    head="Dampening Tam", neck="Loricate Torque +1", ear1="Brutal Earring", ear2="Sherida Earring",
    body=gear.AdhemarJacketPlus1.B, hands=gear.AdhemarWristbandsPlus1.B, ring1="Defending Ring", ring2="Epona's Ring",
    back=gear.stp_jse_back, waist="Windbuffet Belt +1", legs="Samnuha Tights", feet=gear.herculean_ta_feet}

  sets.engaged.PDT = {
    ammo="Staunch Tathlum +1",
    head="Dampening Tam", neck="Loricate Torque +1", ear1="Dudgeon Earring", ear2="Heartseeker Earring",
    body="Meghanada Cuirie +2", hands="Meghanada Gloves +2", ring1="Defending Ring", ring2="Moonbeam Ring",
    back="Moonlight Cape", waist="Flume Belt +1", legs="Meghanada Chausses +2", feet="Ahosi Leggings"}

  sets.engaged.SomeAcc.PDT = {
    ammo="Staunch Tathlum +1",
    head="Dampening Tam", neck="Loricate Torque +1", ear1="Dudgeon Earring", ear2="Heartseeker Earring",
    body="Meghanada Cuirie +2", hands="Meghanada Gloves +2", ring1="Defending Ring", ring2="Patricius Ring",
    back="Moonlight Cape", waist="Flume Belt +1", legs="Meghanada Chausses +2", feet="Ahosi Leggings"}

  sets.engaged.Acc.PDT = {
    ammo="Staunch Tathlum +1",
    head="Dampening Tam", neck="Loricate Torque +1", ear1="Dudgeon Earring", ear2="Heartseeker Earring",
    body="Meghanada Cuirie +2", hands="Meghanada Gloves +2", ring1="Defending Ring", ring2="Patricius Ring",
    back="Moonlight Cape", waist="Flume Belt +1", legs="Meghanada Chausses +2", feet="Ahosi Leggings"}

  sets.engaged.FullAcc.PDT = {
    ammo="Staunch Tathlum +1",
    head="Dampening Tam", neck="Loricate Torque +1", ear1="Dudgeon Earring", ear2="Heartseeker Earring",
    body="Meghanada Cuirie +2", hands="Meghanada Gloves +2", ring1="Defending Ring", ring2="Patricius Ring",
    back="Moonlight Cape", waist="Olseni Belt", legs="Meghanada Chausses +2", feet="Ahosi Leggings"}

  sets.engaged.Fodder.PDT = {
    ammo="Staunch Tathlum +1",
    head="Dampening Tam", neck="Loricate Torque +1", ear1="Dudgeon Earring", ear2="Heartseeker Earring",
    body="Meghanada Cuirie +2", hands="Meghanada Gloves +2", ring1="Defending Ring", ring2=gear.DarkRing.PDT,
    back="Moonlight Cape", waist="Flume Belt +1", legs="Meghanada Chausses +2", feet=gear.herculean_dt_feet}

  --------------------------------------
  -- Precast: Weaponskills
  --------------------------------------

  sets.precast.WS = {
    ammo="Falcon Eye",
    head="Dampening Tam", neck="Asperity Necklace", ear1="Brutal Earring", ear2="Sherida Earring",
    body=gear.AdhemarJacketPlus1.B, hands="Meghanada Gloves +2", ring1="Ilabrat Ring", ring2="Regal Ring",
    back=gear.wsd_jse_back, waist="Grunfeld Rope", legs="Samnuha Tights", feet=gear.herculean_wsd_feet}

  sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, {neck="Combatant's Torque"})
  sets.precast.WS.Acc = set_combine(sets.precast.WS, {
    neck="Combatant's Torque", ear1="Telos Earring", body="Meghanada Cuirie +2", waist="Olseni Belt", legs="Meghanada Chausses +2", feet=gear.herculean_acc_feet})
  sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {
    neck="Combatant's Torque", ear1="Telos Earring", body="Meghanada Cuirie +2", waist="Olseni Belt", legs="Meghanada Chausses +2", feet=gear.herculean_acc_feet})

  sets.precast.WS.Proc = {
    ammo="Yamarang",
    head="Wh. Rarab Cap +1", neck="Loricate Torque +1", ear1="Brutal Earring", ear2="Sanare Earring",
    body="Dread Jupon", hands="Kurys Gloves", ring1="Defending Ring", ring2=gear.DarkRing.PDT,
    back="Moonlight Cape", waist="Flume Belt +1", legs="Dashing Subligar", feet="Ahosi Leggings"}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Ishvara Earring", ear2="Sherida Earring"}
	sets.AccMaxTP = {ear1="Zennaroi Earring", ear2="Sherida Earring"}

  --------------------------------------
  -- Precast: Dagger Weaponskills
  --------------------------------------

  -- Wasp Sting: physical 1-hit, 100% DEX, 1.0 fTP, TP affects duration of poison.

  sets.precast.WS["Wasp Sting"] = set_combine(sets.precast.WS.DEX.WSD, {neck="Fotia Gorget", waist="Fotia Belt"})
  sets.precast.WS["Wasp Sting"].SomeAcc = set_combine(sets.precast.WS.DEX.WSD.SomeAcc, {neck="Fotia Gorget", waist="Fotia Belt"})
  sets.precast.WS["Wasp Sting"].Acc = set_combine(sets.precast.WS.DEX.WSD.Acc, {neck="Fotia Gorget", waist="Fotia Belt"})
  sets.precast.WS["Wasp Sting"].MaxAcc = set_combine(sets.precast.WS.DEX.WSD.FullAcc, {})

  sets.precast.WS["Wasp Sting"].Fodder = set_combine(sets.precast.WS.DEX.WSD.Fodder, {neck="Fotia Gorget", waist="Fotia Belt"})

  -- Gust Slash: magical, wind-ele., 40% DEX 40% INT, 1.0/2.0/3.5 fTP.

  sets.precast.WS['Gust Slash'] = set_combine(sets.precast.WS.Magic, {})

  -- Shadowstitch: physical 1-hit, 100% CHR, 1.0 fTP, TP affects chance to bind.

  sets.precast.WS["Shadowstitch"] = {
    ammo="Falcon Eye",
    head="Meghanada Visor +2", neck="Combatant's Torque", ear1="Mache Earring +1", ear2="Moonshade Earring",
    body="Meghanada Cuirie +2", hands="Meghanada Gloves +2", ring1="Ramuh Ring +1", ring2="Ramuh Ring +1",
    back=gear.ToutatissCape.Crit, waist="Olseni Belt", legs="Meghanada Chausses +2", feet="Meghanada Jambeaux +2"}

  -- Viper Bite: physical 1-hit, 100% DEX, 1.0 fTP, TP affects duration of poison.

  sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS.DEX.WSD, {neck="Fotia Gorget", waist="Fotia Belt"})
  sets.precast.WS["Shark Bite"].SomeAcc = set_combine(sets.precast.WS.DEX.WSD.SomeAcc, {neck="Fotia Gorget", waist="Fotia Belt"})
  sets.precast.WS["Shark Bite"].Acc = set_combine(sets.precast.WS.DEX.WSD.Acc, {neck="Fotia Gorget", waist="Fotia Belt"})
  sets.precast.WS["Shark Bite"].MaxAcc = set_combine(sets.precast.WS.DEX.WSD.FullAcc, {})

  sets.precast.WS["Shark Bite"].Fodder = set_combine(sets.precast.WS.DEX.WSD.Fodder, {neck="Fotia Gorget", waist="Fotia Belt"})

  -- Cyclone: magical AOE, wind-ele., 40% DEX 40% INT, 1.0/2.375/2.875 fTP.

  sets.precast.WS['Cyclone'] = set_combine(sets.precast.WS.Magic, {})

  -- Energy Steal: steals MP, affected by MND and TP.

  sets.precast.WS['Energy Steal'] = set_combine(sets.precast.WS.MaxMND, {})

  -- Energy Drain: steals MP, affected by MND and TP.

  sets.precast.WS['Energy Drain'] = set_combine(sets.precast.WS.MaxMND, {})

  -- Dancing Edge: physical 5-hit, 40% DEX 40% CHR, 1.1875 fTP on all hits, TP affects accuracy.

  sets.precast.WS["Dancing Edge"] = set_combine(sets.precast.WS.DEX.WSD, {neck="Fotia Gorget", waist="Fotia Belt"})
  sets.precast.WS["Dancing Edge"].SomeAcc = set_combine(sets.precast.WS.DEX.WSD.SomeAcc, {neck="Fotia Gorget", waist="Fotia Belt"})
  sets.precast.WS["Dancing Edge"].Acc = set_combine(sets.precast.WS.DEX.WSD.Acc, {neck="Fotia Gorget", waist="Fotia Belt"})
  sets.precast.WS["Dancing Edge"].MaxAcc = set_combine(sets.precast.WS.DEX.WSD.FullAcc, {})

  sets.precast.WS["Dancing Edge"].Fodder = set_combine(sets.precast.WS.DEX.WSD.Fodder, {neck="Fotia Gorget", waist="Fotia Belt"})

  -- Shark Bite: physical 2-hit, 40% DEX 40% AGI, 4.5/6.8/8.5 fTP.

  sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS.DEX.WSD, {ear2="Moonshade Earring"})
  sets.precast.WS["Shark Bite"].SomeAcc = set_combine(sets.precast.WS.DEX.WSD.SomeAcc, {ear2="Moonshade Earring"})
  sets.precast.WS["Shark Bite"].Acc = set_combine(sets.precast.WS.DEX.WSD.Acc, {ear2="Moonshade Earring"})
  sets.precast.WS["Shark Bite"].MaxAcc = set_combine(sets.precast.WS.DEX.WSD.FullAcc, {})

  sets.precast.WS["Shark Bite"].Fodder = set_combine(sets.precast.WS.DEX.WSD.Fodder, {ear2="Moonshade Earring"})

  -- Evisceration: physical 5-hit, 50% DEX, 1.25 fTP on all hits, TP affects chance to crit.

  sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS.DEX.Crit, {
    neck="Fotia Gorget", ear2="Moonshade Earring", waist="Fotia Belt"})
  sets.precast.WS['Evisceration'].SomeAcc = set_combine(sets.precast.WS.DEX.Crit.SomeAcc, {
    neck="Fotia Gorget", ear2="Moonshade Earring", waist="Fotia Belt"})
  sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS.DEX.Crit.Acc, {
    neck="Fotia Gorget", ear2="Moonshade Earring", waist="Fotia Belt"})
  sets.precast.WS['Evisceration'].MaxAcc = set_combine(sets.precast.WS.DEX.Crit.FullAcc, {})

  sets.precast.WS['Evisceration'].Fodder = set_combine(sets.precast.WS.DEX.Crit.Fodder, {
    neck="Fotia Gorget", ear2="Moonshade Earring", waist="Fotia Belt"})

  -- Aeolian Edge: magical AOE, wind-ele., 40% DEX 40% INT, 2.0/3.0/4.5 fTP.

  sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS.Magic, {})
  sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)

  -- Exenterator: physical 4-hit, 73~85% AGI, 1.0 fTP on all hits, TP affects duration of accuracy down.

  sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS.AGI, {neck="Fotia Gorget", waist="Fotia Belt"})
  sets.precast.WS['Exenterator'].SomeAcc = set_combine(sets.precast.WS.AGI.SomeAcc, {neck="Fotia Gorget", waist="Fotia Belt"})
  sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS.AGI.Acc, {neck="Fotia Gorget", waist="Fotia Belt"})
  sets.precast.WS['Exenterator'].MaxAcc = set_combine(sets.precast.WS.AGI.FullAcc, {})

  sets.precast.WS['Exenterator'].Fodder = set_combine(sets.precast.WS.AGI.Fodder, {})

  -- Pyrrhic Kleos: physical 4-hit, 40% STR 40% DEX, 1.75 fTP, TP affects duration of evasion down.

  sets.precast.WS["Pyrrhic Kleos"] = set_combine(sets.precast.WS.DEX.WSD, {ear2="Moonshade Earring"})
  sets.precast.WS["Pyrrhic Kleos"].SomeAcc = set_combine(sets.precast.WS.DEX.WSD.SomeAcc, {ear2="Moonshade Earring"})
  sets.precast.WS["Pyrrhic Kleos"].Acc = set_combine(sets.precast.WS.DEX.WSD.Acc, {ear2="Moonshade Earring"})
  sets.precast.WS["Pyrrhic Kleos"].MaxAcc = set_combine(sets.precast.WS.DEX.WSD.FullAcc, {})

  sets.precast.WS["Pyrrhic Kleos"].Fodder = set_combine(sets.precast.WS.DEX.WSD.Fodder, {ear2="Moonshade Earring"})

  -- Rudra's Storm: physical 1-hit, 80% DEX, 5.0/10.19/13.0 fTP.

  sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS.DEX.WSD, {ear2="Moonshade Earring"})
  sets.precast.WS["Rudra's Storm"].SomeAcc = set_combine(sets.precast.WS.DEX.WSD.SomeAcc, {ear2="Moonshade Earring"})
  sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS.DEX.WSD.Acc, {ear2="Moonshade Earring"})
  sets.precast.WS["Rudra's Storm"].MaxAcc = set_combine(sets.precast.WS.DEX.WSD.FullAcc, {})

  sets.precast.WS["Rudra's Storm"].Fodder = set_combine(sets.precast.WS.DEX.WSD.Fodder, {ear2="Moonshade Earring"})







  sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {head="Lilitu Headpiece", neck="Caro Necklace", ear1="Moonshade Earring", ear2="Ishvara Earring", body=gear.herculean_wsd_body, legs=gear.herculean_wsd_legs})
  sets.precast.WS["Rudra's Storm"].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {head="Lilitu Headpiece", neck="Caro Necklace", ear1="Moonshade Earring", body="Meghanada Cuirie +2", legs=gear.herculean_wsd_legs})
  sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS.Acc, {ear1="Moonshade Earring", body="Meghanada Cuirie +2"})
  sets.precast.WS["Rudra's Storm"].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
  sets.precast.WS["Rudra's Storm"].Fodder = set_combine(sets.precast.WS["Rudra's Storm"], {})

  sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {head="Lilitu Headpiece", neck="Caro Necklace", ear1="Moonshade Earring", ear2="Ishvara Earring", body=gear.herculean_wsd_body, legs=gear.herculean_wsd_legs})
  sets.precast.WS["Shark Bite"].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {head="Lilitu Headpiece", neck="Caro Necklace", ear1="Moonshade Earring", body="Meghanada Cuirie +2", legs=gear.herculean_wsd_legs})
  sets.precast.WS["Shark Bite"].Acc = set_combine(sets.precast.WS.Acc, {ear1="Moonshade Earring", body="Meghanada Cuirie +2"})
  sets.precast.WS["Shark Bite"].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
  sets.precast.WS["Shark Bite"].Fodder = set_combine(sets.precast.WS["Shark Bite"], {})

  sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {ammo="Charis Feather", head="Adhemar Bonnet +1", neck="Fotia Gorget", body="Abnoba Kaftan", hands="Mummu Wrists +2", ring1="Begrudging Ring", waist="Fotia Belt", legs="Darraigner's Brais", feet="Mummu Gamash. +2"})
  sets.precast.WS['Evisceration'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {head="Adhemar Bonnet +1", neck="Fotia Gorget", body="Abnoba Kaftan", hands="Mummu Wrists +2", ring1="Begrudging Ring", waist="Fotia Belt", legs="Mummu Kecks +2", feet="Mummu Gamash. +2"})
  sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS.Acc, {head="Mummu Bonnet +2", ring1="Begrudging Ring", neck="Fotia Gorget", body="Sayadio's Kaftan", hands="Mummu Wrists +2", waist="Fotia Belt", legs="Mummu Kecks +2", feet="Mummu Gamash. +2"})
  sets.precast.WS['Evisceration'].FullAcc = set_combine(sets.precast.WS.FullAcc, {head="Mummu Bonnet +2", body="Mummu Jacket +2", hands="Mummu Wrists +2", legs="Mummu Kecks +2", feet="Mummu Gamash. +2"})
  sets.precast.WS['Evisceration'].Fodder = set_combine(sets.precast.WS['Evisceration'], {})

  sets.precast.WS['Pyrrhic Kleos'] = set_combine(sets.precast.WS, {head="Adhemar Bonnet +1", hands=gear.AdhemarWristbandsPlus1.B, feet=gear.herculean_ta_feet})
  sets.precast.WS['Pyrrhic Kleos'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {head="Adhemar Bonnet +1", hands=gear.AdhemarWristbandsPlus1.B})
  sets.precast.WS['Pyrrhic Kleos'].Acc = set_combine(sets.precast.WS.Acc, {})
  sets.precast.WS['Pyrrhic Kleos'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
  sets.precast.WS['Pyrrhic Kleos'].Fodder = set_combine(sets.precast.WS['Pyrrhic Kleos'], {})

  --------------------------------------
  -- Precast: Job Abilities
  --------------------------------------

  sets.precast.JA['No Foot Rise'] = {body="Horos Casaque +1"}
  sets.precast.JA['Trance'] = {head="Horos Tiara +1"}


  sets.precast.Flourish1 = {}
  sets.precast.Flourish1['Violent Flourish'] = {
    ammo="Falcon Eye",
    head="Dampening Tam", neck="Combatant's Torque", ear1="Telos Earring", ear2="Digni. Earring",
    body="Mummu Jacket +2", hands=gear.AdhemarWristbandsPlus1.B, ring1="Ramuh Ring +1", ring2="Ramuh Ring +1",
    back=gear.stp_jse_back, waist="Olseni Belt", legs="Meghanada Chausses +2", feet=gear.herculean_acc_feet}

  sets.precast.Flourish1['Animated Flourish'] = set_combine(sets.Enmity, {})

  sets.precast.Flourish1['Desperate Flourish'] = {
    ammo="Falcon Eye",
    head="Dampening Tam", neck="Combatant's Torque", ear1="Telos Earring", ear2="Digni. Earring",
    body="Mummu Jacket +2", hands=gear.AdhemarWristbandsPlus1.B, ring1="Ramuh Ring +1", ring2="Ramuh Ring +1",
    back=gear.stp_jse_back, waist="Olseni Belt", legs="Meghanada Chausses +2", feet=gear.herculean_acc_feet}

  sets.precast.Flourish2 = {}
  sets.precast.Flourish2['Reverse Flourish'] = {hands="Maculele Bangles +1", back="Toetapper Mantle"}

  sets.precast.Flourish3 = {}
  sets.precast.Flourish3['Striking Flourish'] = {body-"Maculele Casaque +1"}
  sets.precast.Flourish3['Climactic Flourish'] = {}

  sets.precast.Jig = {legs="Horos Tights +1", feet="Maxixi Shoes +1"}
  sets.precast.Samba = {head="Maxixi Tiara +1", back="Senuna's Mantle"}

  sets.precast.Step = {
    ammo="Falcon Eye",
    head="Dampening Tam", neck="Combatant's Torque", ear1="Telos Earring", ear2="Digni. Earring",
    body="Mummu Jacket +2", hands=gear.AdhemarWristbandsPlus1.B, ring1="Ramuh Ring +1", ring2="Ramuh Ring +1",
    back=gear.stp_jse_back, waist="Olseni Belt", legs="Meghanada Chausses +2", feet=gear.herculean_acc_feet}

  sets.precast.Step['Feather Step'] = set_combine(sets.precast.Step, {feet="Maculele Toeshoes +1"})

  -- Waltz set (chr and vit)
  sets.precast.Waltz = {
    ammo="Yamarang",
    head="Mummu Bonnet +2", neck="Unmoving Collar +1", ear1="Enchntr. Earring +1", ear2="Handler's Earring +1",
    body=gear.herculean_waltz_body, hands=gear.herculean_waltz_hands, ring1="Defending Ring", ring2="Valseur's Ring",
    back="Toetapper Mantle", waist="Chaac Belt", legs="Dashing Subligar", feet=gear.herculean_waltz_feet}

	sets.Self_Waltz = {head="Mummu Bonnet +2", body="Passion Jacket", ring1="Asklepian Ring"}

  -- Don't need any special gear for Healing Waltz.
  sets.precast.Waltz['Healing Waltz'] = {head="Anwig Salade"}

  if player.sub_job == 'WAR' then
    sets.precast.JA.Provoke = set_combine(sets.Enmity, {})
  end

  --------------------------------------
  -- Precast: Fast Cast
  --------------------------------------

  sets.precast.FC = {
    ammo="Impatiens",
		head=gear.HerculeanHelm.MAB, neck="Orunmila's Torque", ear1="Enchanter Earring +1", ear2="Loquacious Earring",
		body=gear.AdhemarJacketPlus1.D, hands="Leyline Gloves", ring1="Lebeche Ring", ring2="Prolix Ring",
		legs=gear.RawhideTrousers.D}

  sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Bead Necklace", body="Passion Jacket"})

  --------------------------------------
  -- Midcast: Fast Recast
  --------------------------------------

  sets.midcast.FastRecast = {
    head=gear.HerculeanHelm.MAB, neck="Orunmila's Torque", ear1="Enchanter Earring +1", ear2="Loquacious Earring",
    body=gear.AdhemarJacketPlus1.D, hands="Leyline Gloves", ring1="Defending Ring", ring2="Prolix Ring",
    back="Moonlight Cape", waist="Flume Belt +1", legs=gear.RawhideTrousers.D, feet=gear.herculean_dt_feet}

  --------------------------------------
  -- Midcast: Ninjutsu
  --------------------------------------

	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {back="Mujin Mantle"})

	--------------------------------------
	-- Active buffs
	--------------------------------------

  sets.buff['Saber Dance'] = {} --legs="Horos Tights"
  sets.buff['Climactic Flourish'] = {ammo="Charis Feather", head="Maculele Tiara +1", body="Meghanada Cuirie +2"}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {head="Frenzy Sallet"}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(10, 9)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 9)
    elseif player.sub_job == 'SAM' then
        set_macro_page(9, 9)
    elseif player.sub_job == 'THF' then
        set_macro_page(8, 9)
    else
        set_macro_page(10, 9)
    end
end
