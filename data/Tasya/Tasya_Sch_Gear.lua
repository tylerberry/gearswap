-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
  state.OffenseMode:options('Normal')
  state.CastingMode:options('Normal', 'Resistant', 'Proc', 'OccultAcumen')
  state.IdleMode:options('Normal', 'PDT', 'TPEat')
	state.HybridMode:options('Normal', 'PDT')
	state.Weapons:options('None', 'Akademos', 'Khatvanga')

	gear.nuke_jse_back = {name="Lugh's Cape", augments={'INT+20', 'Mag. Acc+20 /Mag. Dmg.+20', '"Mag.Atk.Bns."+10'}}

	gear.obi_cure_back = "Tempered Cape +1"
	gear.obi_cure_waist = "Witful Belt"

	gear.obi_low_nuke_waist = "Refoccilation Stone"
	gear.obi_high_nuke_waist = "Refoccilation Stone"

	-- Additional local binds
	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind !` gs c scholar power')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind ^q gs c weapons Khatvanga;gs c set CastingMode OccultAcumen')
	send_command('bind !q gs c weapons default;gs c reset CastingMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind !pause gs c toggle AutoSubMode') -- Automatically uses sublimation and Myrkr.
	send_command('bind @^` input /ja "Parsimony" <me>')
	send_command('bind ^backspace input /ma "Stun" <t>')
	send_command('bind !backspace gs c scholar speed')
	send_command('bind @backspace gs c scholar aoe')
	send_command('bind ^= input /ja "Dark Arts" <me>')
	send_command('bind != input /ja "Light Arts" <me>')
	send_command('bind ^\\\\ input /ma "Protect V" <t>')
	send_command('bind @\\\\ input /ma "Shell V" <t>')
	send_command('bind !\\\\ input /ma "Reraise III" <me>')

  select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()

  --------------------------------------
  -- Sets required by rules
  --------------------------------------

  sets.Kiting = {feet="Crier's Gaiters"}
  sets.latent_refresh = {waist="Fucho-no-Obi"}
	sets.DayIdle = {}
	sets.NightIdle = {}

	sets.Self_Healing = {neck="Phalaina Locket", ring1="Kunaji Ring", ring2="Asklepian Ring", waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket", ring1="Kunaji Ring", ring2="Asklepian Ring", waist="Gishdubar Sash"}
	sets.Self_Refresh = {back="Grapevine Cape", waist="Gishdubar Sash", feet="Inspirited Boots"}

  sets.HPDown = {
    head="Pixie Hairpin +1", ear1="Mendicant's Earring", ear2="Evans Earring",
    body="Zendik Robe", hands="Hieros Mittens", ring1="Mephitas's Ring +1", ring2="Mephitas's Ring",
    back="Swith Cape +1", waist="Flax Sash", legs="Shedir Seraweels", feet=""}

  sets.MagicBurst = {
    main="Akademos",
    neck="Mizu. Kubikazari",
    hands="Amalric Gages +1", ring1="Mujin Band", ring2="Locus Ring",
    feet="Jhakri Pigaches +2"}

	sets.RecoverMP = {body="Seidr Cotehardie"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {feet=gear.chironic_treasure_feet})

  --------------------------------------
  -- Base sets
  --------------------------------------

  --------------------------------------
  -- Elemental Affinity
  --------------------------------------

	sets.element.Wind = {main="Marin Staff +1"}
	sets.element.Ice = {main="Ngqoqwanb"}
	sets.element.Earth = {neck="Quanpur Necklace"}
	sets.element.Dark = {head="Pixie Hairpin +1", ring2="Archon Ring"}

  --------------------------------------
  -- Idle
  --------------------------------------

  sets.idle = {
    main="Bolelabunga", sub="Genmei Shield", ammo="Homiliary",
    head="Befouled Crown", neck="Loricate Torque +1", ear1="Etiolation Earring", ear2="Ethereal Earring",
    body="Jhakri Robe +2", hands=gear.merlinic_refresh_hands, ring1="Defending Ring", ring2=gear.DarkRing.PDT,
    back="Moonlight Cape", waist="Flax Sash", legs="Assiduity Pants +1", feet=gear.chironic_refresh_feet}

  sets.idle.PDT = {
    main="Terra's Staff", sub="Oneiros Grip", ammo="Staunch Tathlum +1",
    head="Gendewitha Caubeen +1", neck="Loricate Torque +1", ear1="Etiolation Earring", ear2="Ethereal Earring",
    body="Vrikodara Jupon", hands="Gendewitha Gages +1", ring1="Defending Ring", ring2=gear.DarkRing.PDT,
    back="Moonlight Cape", waist="Flax Sash", legs="Hagondes Pants +1", feet=gear.chironic_refresh_feet}

  sets.idle.Hippo = set_combine(sets.idle.PDT, {feet="Hippomenes Socks +1"})

  sets.idle.Weak = {
    main="Bolelabunga", sub="Genmei Shield", ammo="Homiliary",
    head="Befouled Crown", neck="Loricate Torque +1", ear1="Etiolation Earring", ear2="Ethereal Earring",
    body="Jhakri Robe +2", hands=gear.merlinic_refresh_hands, ring1="Defending Ring", ring2=gear.DarkRing.PDT,
    back="Moonlight Cape", waist="Flax Sash", legs="Assiduity Pants +1", feet=gear.chironic_refresh_feet}

  sets.idle.TPEat = set_combine(sets.idle, {neck="Chrys. Torque"})

  --------------------------------------
  -- Defense
  --------------------------------------

  sets.defense.PDT = {
    main="Terra's Staff", sub="Umbra Strap", ammo="Staunch Tathlum +1",
    head="Gendewitha Caubeen +1", neck="Loricate Torque +1", ear1="Etiolation Earring", ear2="Ethereal Earring",
    body="Mallquis Saio +2", hands="Gendewitha Gages +1", ring1="Defending Ring", ring2=gear.DarkRing.PDT,
    back="Moonlight Cape", waist="Flax Sash", legs="Hagondes Pants +1", feet="Battlecast Gaiters"}

  sets.defense.MDT = {
    main="Terra's Staff", sub="Umbra Strap", ammo="Staunch Tathlum +1",
    head="Gendewitha Caubeen +1", neck="Loricate Torque +1", ear1="Etiolation Earring", ear2="Ethereal Earring",
    body="Mallquis Saio +2", hands="Gendewitha Gages +1", ring1="Defending Ring", ring2=gear.DarkRing.PDT,
    back="Moonlight Cape", waist="Flax Sash", legs="Hagondes Pants +1", feet="Battlecast Gaiters"}

  sets.defense.MEVA = {
    main="Oranyan", sub="Umbra Strap", ammo="Staunch Tathlum +1",
    head=gear.merlinic_nuke_head, neck="Warder's Charm +1", ear1="Etiolation Earring", ear2="Sanare Earring",
    body=gear.merlinic_nuke_body, hands="Gendewitha Gages +1", ring1="Vengeful Ring", ring2="Purity Ring",
    back=gear.nuke_jse_back, waist="Acuity Belt +1", legs="Merlinic Shalwar", feet=gear.merlinic_nuke_feet}

  --------------------------------------
  -- Resting
  --------------------------------------

  sets.resting = {
    main="Chatoyant Staff", sub="Oneiros Grip", ammo="Homiliary",
		head="Befouled Crown", neck="Chrys. Torque", ear1="Etiolation Earring", ear2="Ethereal Earring",
		body="Amalric Doublet", hands=gear.merlinic_refresh_hands, ring1="Defending Ring", ring2=gear.DarkRing.PDT,
		back="Moonlight Cape", waist="Fucho-no-obi", legs="Assiduity Pants +1", feet=gear.chironic_refresh_feet}

  --------------------------------------
  -- Weapons
  --------------------------------------

	sets.weapons.Akademos = {main="Akademos", sub="Enki Strap"}
	sets.weapons.Khatvanga = {main="Khatvanga", sub="Bloodrain Strap"}

  --------------------------------------
  -- Engaged
  --------------------------------------

  -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
  -- sets if more refined versions aren't defined.
  -- If you create a set with both offense and defense modes, the offense mode should be first.
  -- EG: sets.engaged.Dagger.Accuracy.Evasion

  sets.engaged = {
    main="Bolelabunga", sub="Genmei Shield", ammo="Homiliary",
    head="Befouled Crown", neck="Loricate Torque +1", ear1="Etiolation Earring", ear2="Ethereal Earring",
    body="Jhakri Robe +2", hands=gear.merlinic_refresh_hands, ring1="Defending Ring", ring2="Sheltered Ring",
    back="Moonlight Cape", waist="Flax Sash", legs="Assiduity Pants +1", feet=gear.chironic_refresh_feet}

  sets.engaged.PDT = {
    main="Terra's Staff", sub="Oneiros Grip", ammo="Staunch Tathlum +1",
    head="Gendewitha Caubeen +1", neck="Loricate Torque +1", ear1="Etiolation Earring", ear2="Ethereal Earring",
    body="Vrikodara Jupon", hands="Gendewitha Gages +1", ring1="Defending Ring", ring2=gear.DarkRing.PDT,
    back="Moonlight Cape", waist="Flax Sash", legs="Hagondes Pants +1", feet=gear.chironic_refresh_feet}

  --------------------------------------
  -- Precast: Weaponskills
  --------------------------------------

  sets.precast.WS['Myrkr'] = {
    ammo="Staunch Tathlum +1",
  	head="Pixie Hairpin +1", neck="Sanctity Necklace", ear1="Evans Earring", ear2="Etiolation Earring",
  	body="Amalric Doublet", hands="Regal Cuffs", ring1="Mephitas's Ring +1", ring2="Mephitas's Ring",
  	back="Aurist's Cape +1", waist="Yamabuki-no-Obi", legs=gear.PsyclothLappas.D, feet="Medium's Sabots"}

  --------------------------------------
  -- Precast: Job Abilities
  --------------------------------------

  sets.precast.JA['Tabula Rasa'] = {legs="Pedagogy Pants +1"}
	sets.precast.JA['Enlightenment'] = {} --body="Pedagogy Gown +1"

  --------------------------------------
  -- Precast: Fast Cast
  --------------------------------------

  sets.precast.FC = {
    main=gear.Grioavolr.MAB, sub="Clerisy Strap +1", ammo="Impatiens",
    head="Amalric Coif +1", neck="Orunmila's Torque", ear1="Enchanter Earring +1", ear2="Loquacious Earring",
    body="Zendik Robe", hands="Gendewitha Gages +1", ring1="Kishar Ring", ring2="Lebeche Ring",
    back="Perimede Cape", waist="Witful Belt", legs=gear.PsyclothLappas.D, feet="Regal Pumps +1"}

	sets.precast.FC.Arts = {}

  sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {ear1="Barkarole Earring"})
  sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

  sets.precast.FC.Cure = set_combine(sets.precast.FC, {main="Serenity", sub="Clerisy Strap +1", body="Heka's Kalasiris"})

  sets.precast.FC.Curaga = sets.precast.FC.Cure

  sets.precast.FC.Impact = set_combine(sets.precast.FC['Elemental Magic'], {head=empty, body="Twilight Cloak"})

  --------------------------------------
  -- Midcast: Fast Recast
  --------------------------------------

  sets.midcast.FastRecast = {
    main=gear.Grioavolr.MAB, sub="Clerisy Strap +1", ammo="Hasty Pinion +1",
		head="Amalric Coif +1", neck="Orunmila's Torque", ear1="Enchanter Earring +1", ear2="Loquacious Earring",
		body="Zendik Robe", hands="Gendewitha Gages +1", ring1="Kishar Ring", ring2="Prolix Ring",
		back="Swith Cape +1", waist="Witful Belt", legs=gear.PsyclothLappas.D, feet="Regal Pumps +1"}

  --------------------------------------
  -- Midcast: Dark Magic
  --------------------------------------

  sets.midcast['Dark Magic'] = {
    main="Rubicundity", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
    head="Amalric Coif +1", neck="Incanter's Torque", ear1="Regal Earring", ear2="Barkarole Earring",
    body="Chironic Doublet", hands=gear.chironic_enfeeble_hands, ring1="Stikini Ring +1", ring2="Stikini Ring +1",
    back=gear.nuke_jse_back, waist="Acuity Belt +1", legs="Chironic Hose", feet=gear.merlinic_aspir_feet}

  sets.midcast.Aspir = {
    main="Rubicundity", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
    head="Pixie Hairpin +1", neck="Erra Pendant", ear1="Regal Earring", ear2="Barkarole Earring",
    body="Chironic Doublet", hands=gear.chironic_enfeeble_hands, ring1="Evanescence Ring", ring2="Archon Ring",
    back=gear.nuke_jse_back, waist="Fucho-no-Obi", legs="Chironic Hose", feet=gear.merlinic_aspir_feet}

  sets.midcast.Aspir.Resistant = {
    main="Rubicundity", sub="Ammurapi Shield", ammo="Pemphredo Tathlum",
    head="Amalric Coif +1", neck="Erra Pendant", ear1="Regal Earring", ear2="Barkarole Earring",
    body="Chironic Doublet", hands=gear.chironic_enfeeble_hands, ring1="Stikini Ring +1", ring2="Stikini Ring +1",
    back=gear.nuke_jse_back, waist="Acuity Belt +1", legs="Chironic Hose", feet=gear.merlinic_aspir_feet}

  sets.midcast.Bio = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
  sets.midcast['Bio II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)

  sets.midcast.Drain = set_combine(sets.midcast.Aspir, {})
  sets.midcast.Drain.Resistant = set_combine(sets.midcast.Aspir.Resistant, {})

  sets.midcast.Kaustra = {
    main="Akademos", sub="Niobid Strap", ammo="Pemphredo Tathlum",
    head="Pixie Hairpin +1", neck="Saevus Pendant +1", ear1="Crematio Earring", ear2="Barkarole Earring",
    body=gear.merlinic_nuke_body, hands="Amalric Gages +1", ring1="Shiva Ring +1", ring2="Archon Ring",
    back=gear.nuke_jse_back, waist="Refoccilation Stone", legs="Merlinic Shalwar", feet=gear.merlinic_nuke_feet}

  sets.midcast.Kaustra.Resistant = {
    main=gear.grioavolr_nuke_staff, sub="Niobid Strap", ammo="Pemphredo Tathlum",
    head=gear.merlinic_nuke_head, neck="Erra Pendant", ear1="Crematio Earring", ear2="Barkarole Earring",
    body=gear.merlinic_nuke_body, hands="Amalric Gages +1", ring1="Shiva Ring +1", ring2="Shiva Ring +1",
    back=gear.nuke_jse_back, waist="Acuity Belt +1", legs="Merlinic Shalwar", feet=gear.merlinic_nuke_feet}

  sets.midcast.Stun = {
    main="Oranyan", sub="Clerisy Strap +1", ammo="Hasty Pinion +1",
    head="Amalric Coif +1", neck="Orunmila's Torque", ear1="Enchanter Earring +1", ear2="Loquacious Earring",
    body="Zendik Robe", hands="Gendewitha Gages +1", ring1="Kishar Ring", ring2="Stikini Ring +1",
    back=gear.nuke_jse_back, waist="Witful Belt", legs=gear.PsyclothLappas.D, feet="Regal Pumps +1"}

  sets.midcast.Stun.Resistant = {
    main="Oranyan", sub="Enki Strap", ammo="Pemphredo Tathlum",
    head="Amalric Coif +1", neck="Erra Pendant", ear1="Regal Earring", ear2="Barkarole Earring",
    body="Zendik Robe", hands=gear.chironic_enfeeble_hands, ring1="Stikini Ring +1", ring2="Stikini Ring +1",
    back=gear.nuke_jse_back, waist="Acuity Belt +1", legs="Chironic Hose", feet=gear.merlinic_aspir_feet}

  --------------------------------------
  -- Midcast: Divine Magic
  --------------------------------------

  sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'], {
    ring1="Stikini Ring +1", feet=gear.chironic_nuke_feet})

  --------------------------------------
  -- Midcast: Elemental Magic
  --------------------------------------

  sets.midcast['Elemental Magic'] = {
    main="Akademos", sub="Zuuxowu Grip", ammo="Dosis Tathlum",
    head=gear.merlinic_nuke_head, neck="Saevus Pendant +1", ear1="Crematio Earring", ear2="Friomisi Earring",
    body=gear.merlinic_nuke_body, hands="Mallquis Cuffs +2", ring1="Shiva Ring +1", ring2="Shiva Ring +1",
    back=gear.nuke_jse_back, waist=gear.ElementalObi, legs="Merlinic Shalwar", feet=gear.merlinic_nuke_feet}

  sets.midcast['Elemental Magic'].Resistant = {
    main=gear.grioavolr_nuke_staff, sub="Niobid Strap", ammo="Pemphredo Tathlum",
    head=gear.merlinic_nuke_head, neck="Sanctity Necklace", ear1="Crematio Earring", ear2="Barkarole Earring",
    body=gear.merlinic_nuke_body, hands="Mallquis Cuffs +2", ring1="Shiva Ring +1", ring2="Shiva Ring +1",
    back=gear.nuke_jse_back, waist="Yamabuki-no-Obi", legs="Merlinic Shalwar", feet=gear.merlinic_nuke_feet}

  sets.midcast['Elemental Magic'].Fodder = {
    main="Akademos", sub="Zuuxowu Grip", ammo="Dosis Tathlum",
    head=gear.merlinic_nuke_head, neck="Saevus Pendant +1", ear1="Crematio Earring", ear2="Friomisi Earring",
    body=gear.merlinic_nuke_body, hands="Mallquis Cuffs +2", ring1="Shiva Ring +1", ring2="Shiva Ring +1",
    back=gear.nuke_jse_back, waist=gear.ElementalObi, legs="Merlinic Shalwar", feet=gear.merlinic_nuke_feet}

  sets.midcast['Elemental Magic'].Proc = {
    main=empty, sub=empty, ammo="Impatiens",
    head="Nahtirah Hat", neck="Voltsurge Torque", ear1="Enchanter Earring +1", ear2="Loquacious Earring",
    body="Helios Jacket", hands="Gendewitha Gages +1", ring1="Kishar Ring", ring2="Prolix Ring",
    back="Swith Cape +1", waist="Witful Belt", legs=gear.PsyclothLappas.D, feet="Regal Pumps +1"}

  sets.midcast['Elemental Magic'].OccultAcumen = {
    main="Khatvanga", sub="Bloodrain Strap", ammo="Seraphic Ampulla",
    head="Mall. Chapeau +2", neck="Combatant's Torque", ear1="Dedition Earring", ear2="Telos Earring",
    body=gear.merlinic_occult_body, hands=gear.merlinic_occult_hands, ring1="Rajas Ring", ring2="Petrov Ring",
    back=gear.nuke_jse_back, waist="Oneiros Rope", legs="Perdition Slops", feet=gear.merlinic_occult_feet}

  -- Custom refinements for certain nuke tiers
  sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {main="Akademos", sub="Niobid Strap", ammo="Pemphredo Tathlum", ear1="Regal Earring", ear2="Barkarole Earring", hands="Amalric Gages +1"})
  sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, {main=gear.grioavolr_nuke_staff, sub="Niobid Strap", ammo="Pemphredo Tathlum", ear1="Regal Earring", ear2="Barkarole Earring", hands="Amalric Gages +1"})
  sets.midcast['Elemental Magic'].HighTierNuke.Fodder = set_combine(sets.midcast['Elemental Magic'].Fodder, {sub="Alber Strap", ammo="Pemphredo Tathlum", ear1="Regal Earring", ear2="Barkarole Earring", hands="Amalric Gages +1"})

  sets.midcast.Helix = {
    main="Akademos", sub="Zuuxowu Grip", ammo="Dosis Tathlum",
    head=gear.merlinic_nuke_head, neck="Saevus Pendant +1", ear1="Crematio Earring", ear2="Friomisi Earring",
    body=gear.merlinic_nuke_body, hands="Amalric Gages +1", ring1="Shiva Ring +1", ring2="Shiva Ring +1",
    back=gear.nuke_jse_back, waist="Refoccilation Stone", legs="Merlinic Shalwar", feet=gear.merlinic_nuke_feet}

  sets.midcast.Helix.Resistant = {
    main=gear.grioavolr_nuke_staff, sub="Niobid Strap", ammo="Pemphredo Tathlum",
    head=gear.merlinic_nuke_head, neck="Sanctity Necklace", ear1="Barkarole Earring", ear2="Friomisi Earring",
    body=gear.merlinic_nuke_body, hands="Amalric Gages +1", ring1="Shiva Ring +1", ring2="Shiva Ring +1",
    back=gear.nuke_jse_back, waist="Acuity Belt +1", legs="Merlinic Shalwar", feet=gear.merlinic_nuke_feet}

  sets.midcast.Helix.Proc = {
    main=empty, sub=empty, ammo="Impatiens",
    head="Nahtirah Hat", neck="Voltsurge Torque", ear1="Enchanter Earring +1", ear2="Loquacious Earring",
    body="Helios Jacket", hands="Gendewitha Gages +1", ring1="Kishar Ring", ring2="Prolix Ring",
    back="Swith Cape +1", waist="Witful Belt", legs=gear.PsyclothLappas.D, feet="Regal Pumps +1"}

  sets.midcast.Impact = {
    main="Oranyan", sub="Enki Strap", ammo="Pemphredo Tathlum",
    head=empty, neck="Erra Pendant", ear1="Regal Earring", ear2="Barkarole Earring",
    body="Twilight Cloak", hands=gear.chironic_enfeeble_hands, ring1="Stikini Ring +1", ring2="Stikini Ring +1",
    back=gear.nuke_jse_back, waist="Acuity Belt +1", legs="Merlinic Shalwar", feet=gear.merlinic_nuke_feet}

  sets.midcast.Impact.OccultAcumen = set_combine(sets.midcast['Elemental Magic'].OccultAcumen, {head=empty, body="Twilight Cloak"})

  sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {head="Amalric Coif +1", ear2="Barkarole Earring", back=gear.nuke_jse_back, waist="Acuity Belt +1"})
  sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {head="Amalric Coif +1", ear2="Barkarole Earring", back=gear.nuke_jse_back, waist="Acuity Belt +1"})

  --------------------------------------
  -- Midcast: Enfeebling Magic
  --------------------------------------

  sets.midcast['Enfeebling Magic'] = {
    main="Oranyan", sub="Enki Strap", ammo="Pemphredo Tathlum",
    head="Befouled Crown", neck="Erra Pendant", ear1="Regal Earring", ear2="Digni. Earring",
    body="Chironic Doublet", hands="Regal Cuffs", ring1="Kishar Ring", ring2="Stikini Ring +1",
    back=gear.nuke_jse_back, waist="Luminary Sash", legs="Chironic Hose", feet="Uk'uxkaj Boots"}

  sets.midcast['Enfeebling Magic'].Resistant = {
    main="Oranyan", sub="Enki Strap", ammo="Pemphredo Tathlum",
    head="Befouled Crown", neck="Erra Pendant", ear1="Regal Earring", ear2="Digni. Earring",
    body="Chironic Doublet", hands=gear.chironic_enfeeble_hands, ring1="Stikini Ring +1", ring2="Stikini Ring +1",
    back=gear.nuke_jse_back, waist="Luminary Sash", legs="Chironic Hose", feet="Medium's Sabots"}

  sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {head="Amalric Coif +1", ear1="Barkarole Earring", back=gear.nuke_jse_back, waist="Acuity Belt +1"})
  sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {head="Amalric Coif +1", ear2="Barkarole Earring", back=gear.nuke_jse_back, waist="Acuity Belt +1"})

  sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {ring1="Stikini Ring +1"})
  sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {ring1="Stikini Ring +1"})

  sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)

  --------------------------------------
  -- Midcast: Enhancing Magic
  --------------------------------------

	sets.midcast['Enhancing Magic'] = {main=gear.gada_enhancing_club, sub="Ammurapi Shield", ammo="Hasty Pinion +1",
		head="Telchine Cap", neck="Incanter's Torque", ear1="Andoaa Earring", ear2="Gifted Earring",
		body="Telchine Chas.", hands="Telchine Gloves", ring1="Stikini Ring +1", ring2="Stikini Ring +1",
		back="Perimede Cape", waist="Olympus Sash", legs="Telchine Braconi", feet="Telchine Pigaches"}

	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {main="Vadose Rod", sub="Genmei Shield", head="Amalric Coif +1", hands="Regal Cuffs", waist="Emphatikos Rope", legs="Shedir Seraweels"})

	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {legs="Shedir Seraweels"})

  sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
  sets.midcast.Protectra = sets.midcast.Protect

	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric Coif +1"})

  sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {back=gear.nuke_jse_back})

  sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
  sets.midcast.Shellra = sets.midcast.Shell

  sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
    neck="Nodens Gorget", ear2="Earthcry Earring", waist="Siegel Sash", legs="Shedir Seraweels"})

  sets.midcast.Storm = set_combine(sets.midcast['Enhancing Magic'], {feet="Pedagogy Loafers +1"})

  --------------------------------------
  -- Midcast: Healing Magic
  --------------------------------------

  sets.midcast.Cure = {
    main="Serenity", sub="Curatio Grip", ammo="Hasty Pinion +1",
    head="Gendewitha Caubeen +1", neck="Incanter's Torque", ear1="Enchanter Earring +1", ear2="Loquacious Earring",
    body="Kaykaus Bliaut", hands="Kaykaus Cuffs", ring1="Janniston Ring", ring2="Lebeche Ring",
    back="Tempered Cape +1", waist="Luminary Sash", legs="Chironic Hose", feet="Kaykaus Boots"}

  sets.midcast.LightWeatherCure = {
    main="Chatoyant Staff", sub="Curatio Grip", ammo="Hasty Pinion +1",
    head="Gendewitha Caubeen +1", neck="Incanter's Torque", ear1="Enchanter Earring +1", ear2="Loquacious Earring",
    body="Kaykaus Bliaut", hands="Kaykaus Cuffs", ring1="Janniston Ring", ring2="Lebeche Ring",
    back="Twilight Cape", waist="Hachirin-no-Obi", legs="Chironic Hose", feet="Kaykaus Boots"}

  sets.midcast.LightDayCure = {
    main="Serenity", sub="Curatio Grip", ammo="Hasty Pinion +1",
    head="Gendewitha Caubeen +1", neck="Incanter's Torque", ear1="Enchanter Earring +1", ear2="Loquacious Earring",
    body="Kaykaus Bliaut", hands="Kaykaus Cuffs", ring1="Janniston Ring", ring2="Lebeche Ring",
    back="Twilight Cape", waist="Hachirin-no-Obi", legs="Chironic Hose", feet="Kaykaus Boots"}

  sets.midcast.Curaga = sets.midcast.Cure

	sets.midcast.Cursna = {
    main="Oranyan", sub="Clemency Grip", ammo="Hasty Pinion +1",
		head="Amalric Coif +1", neck="Debilis Medallion", ear1="Enchanter Earring +1", ear2="Loquacious Earring",
		body="Zendik Robe", hands="Hieros Mittens", ring1="Haoma's Ring", ring2="Menelaus's Ring",
		back="Swith Cape +1", waist="Witful Belt", legs=gear.PsyclothLappas.D, feet="Vanya Clogs"}

	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {main="Oranyan", sub="Clemency Grip"})

  --------------------------------------
  -- Active Buffs
  --------------------------------------

  sets.buff['Alacrity'] = {feet="Pedagogy Loafers +1"}
  sets.buff['Ebullience'] = {head="Arbatel Bonnet +1"}
  sets.buff['Celerity'] = {feet="Pedagogy Loafers +1"}
  sets.buff['Immanence'] = {hands="Arbatel Bracers +1"}
  sets.buff['Klimaform'] = {feet="Arbatel Loafers +1"}
  sets.buff['Parsimony'] = {legs="Arbatel Pants +1"}
  sets.buff['Penury'] = {legs="Arbatel Pants +1"}
  sets.buff['Perpetuance'] = {hands="Arbatel Bracers +1"}
  sets.buff['Rapture'] = {head="Arbatel Bonnet +1"}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff['Light Arts'] = {} --legs="Academic's Pants +3"
	sets.buff['Dark Arts'] = {} --body="Academic's Gown +3"

  sets.buff.FullSublimation = {}
  sets.buff.PDTSublimation = {}
end

-- Select default macro book on initial load or subjob change.
-- Default macro set/book
function select_default_macro_book()
	if player.sub_job == 'RDM' then
		set_macro_page(1, 18)
	elseif player.sub_job == 'BLM' then
		set_macro_page(1, 18)
	elseif player.sub_job == 'WHM' then
		set_macro_page(1, 18)
	else
		set_macro_page(1, 18)
	end
end
