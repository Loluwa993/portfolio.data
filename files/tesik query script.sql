create table clients(
	client_id int primary key,
	client_name varchar(30),
	business_sector varchar(30)
);

create table rfx(
	rfx_id int primary key,
	rfx_date text,
	rfx_no int,
	client_id int,
	rfx_descripton text,
	rfx_value decimal,
	rfx_status text,
	foreign key (client_id) references clients(client_id)
);

create table orders(
	order_id int primary key,
	order_date text,
	client_id int,
	order_description text,
	order_value decimal,
	foreign key (client_id) references clients(client_id)
);

create table order_service(
	service_id int,
	order_id int,
	"service" text,
	service_dept text,
	service_status text,
	foreign key (order_id) references orders(order_id)
);

select * from rfx;
select * from clients;
select * from orders;
select * from order_service;

/*--inserting values into the tables--*/

insert into clients
values
('72', 'ABNS', 'Private'),
	('97', 'ABBV', 'Production'),
	('79', 'ADPC', 'Power'),
	('39', 'ALME', 'Engineering'),
	('80', 'AELM', 'Oil & Gas'),
	('30', 'AGP', 'Oil & Gas'),
	('6', 'AP', 'Manufacturing'),
	('65', 'AMEL', 'Engineering'),
	('67', 'AS-SAMI', 'Consulting'),
	('60', 'AELT', 'Oil & Gas'),
	('69', 'BACH', 'Real Estate'),
	('99', 'BELS', 'Engineering'),
	('59', 'BRGP', 'Production'),
	('7', 'BDME', 'Maritime'),
	('76', 'BRHI', 'Private'),
	('8', 'BAT', 'Production'),
	('9', 'BEL', 'Engineering'),
	('71', 'BUAG', 'Manufacturing'),
	('10', 'CMI', 'Production'),
	('11', 'CAC', 'Religion'),
	('64', 'CPL', 'Oil & Gas'),
	('81', 'CALS', 'Production'),
	('49', 'CETS', 'Engineering'),
	('55', 'DNG', 'Manufacturing'),
	('12', 'DAEL', 'Engineering'),
	('61', 'DELG', 'Engineering'),
	('13', 'DEC', 'Engineering'),
	('82', 'DLES', 'Engineering'),
	('56', 'DMCS', 'Oil & Gas'),
	('3', 'ESR-LSL', 'Health'),
	('45', 'EPGN', 'Power'),
	('14', 'FMP', 'Production'),
	('83', 'FNCL', 'Engineering'),
	('40', 'FIPN', 'Oil & Gas'),
	('58', 'FESR', 'Oil & Gas'),
	('70', 'GMH', 'Real Estate'),
	('31', 'GMT', 'Engineering'),
	('84', 'HFLL', 'Production'),
	('85', 'IBDPC', 'Power'),
	('73', 'IKPC', 'Power'),
	('100', 'IMRDC', 'Oil & Gas'),
	('51', 'IREL', 'Real Estate'),
	('15', 'IETL', 'Engineering'),
	('86', 'KRPGS', 'Oil & Gas'),
	('32', 'KED', 'Power'),
	('48', 'KGRS', 'Manufacturing'),
	('16', 'KAIL', 'Production'),
	('34', 'KNCV', 'Non-Govermental'),
	('78', 'KELS', 'Engineering'),
	('87', 'LSGM', 'Govermental'),
	('17', 'LIL', 'Real Estate'),
	('18', 'METL', 'Power'),
	('46', 'MPLL', 'Oil & Gas'),
	('98', 'MEG', 'Engineering'),
	('68', 'MPC', 'Production'),
	('29', 'MEW', 'Govermental'),
	('19', 'ME', 'Engineering'),
	('57', 'MISL', 'Engineering'),
	('50', 'NESPL', 'Oil & Gas'),
	('63', 'NHPI', 'Manufacturing'),
	('53', 'NPSE', 'Oil & Gas'),
	('41', 'NDPC', 'Power'),
	('42', 'NFE', 'Maritime'),
	('77', 'NPDDC', 'Oil & Gas'),
	('2', 'NBL', 'Production'),
	('75', 'NLGN', 'Oil & Gas'),
	('21', 'NPNC', 'Oil & Gas'),
	('88', 'NPSCLS', 'Oil & Gas'),
	('36', 'NPA', 'Maritime'),
	('52', 'NNFMS', 'Oil & Gas'),
	('20', 'NSPS', 'Power'),
	('54', 'OSET', 'Oil & Gas'),
	('89', 'OITGSL', 'Manufacturing'),
	('37', 'OTL', 'Maritime'),
	('33', 'ONL', 'Agriculture'),
	('4', 'PEPS', 'Production'),
	('66', 'PRS', 'Consulting'),
	('35', 'PTL', 'Engineering'),
	('22', 'PPSL', 'Engineering'),
	('90', 'PHRS', 'Oil & Gas'),
	('91', 'PSLEG', 'Engineering'),
	('43', 'PZC', 'Production'),
	('23', 'SE', 'Oil & Gas'),
	('96', 'SNDM', 'Manufacturing'),
	('24', 'SPDL', 'Oil & Gas'),
	('5', 'SNEPC', 'Oil & Gas'),
	('92', 'SHP', 'Power'),
	('38', 'STK', 'Engineering'),
	('93', 'SNLN', 'Engineering'),
	('1', 'SGSE', 'Production'),
	('47', 'SYG', 'Production'),
	('44', 'TSRV', 'Manufacturing'),
	('62', 'TEPS', 'Oil & Gas'),
	('25', 'TFAI', 'Agriculture'),
	('26', 'TEP', 'Oil & Gas'),
	('27', 'TTN', 'Power'),
	('94', 'WRPG', 'Oil & Gas'),
	('28', 'WGP', 'Oil & Gas'),
	('74', 'YDPC', 'Power'),
	('95', 'ZCNL', 'Engineering');

insert into rfx
values
	('1', '04/01/2022', '141106', '1', 'Supply of Items for First Aid Box', '401762.5', 'Y'),
	('2', '04/01/2022', '241106', '2', 'Supply of Reflective Jackets (600)', '1680000', 'N'),
	('3', '16/12/2021', '31612104', '3', 'Refilling of Fire Extinguishers at Wuse-2 Branch', '123000', 'Y'),
	('4', '05/01/2022', '451100', '63', 'Concrete Casting for 40ft Container', '1029250', 'Y'),
	('5', '06/01/2022', '561106', '10', 'SUPPLY OF DISPOSABLE NOSE MASK AND MESH CAP', '1435000', 'N'),
	('6', '06/01/2022', '661106', '10', 'SUPPLY OF RUBBER HAND GLOVES', '816000', 'N'),
	('7', '10/01/2022', '7101106', '14', 'Mop Cap', '252000', 'Y'),
	('8', '12/01/2022', '8121102', '2', 'MRP EDIT & ORDER 70488936- SKF BEARINGS', '439770.24', 'N'),
	('9', '13/01/2022', '9131101', '2', 'LINE 4 WASHER FINAL RINSE WATER RECOVARY MODIFICATION', '4098000', 'N'),
	('10', '13/01/2022', '10131102', '2', 'ATEX Single-Phase Industrial Vacuum Cleaner A337MX1.3D', '4715925', 'N'),
	('11', '13/01/2022', '11131106', '16', 'Safety Boots', '808800', 'Y'),
	('12', '13/01/2022', '12131108', '2', 'Supply of Convex Mirror in Logistics Walkway', '502600', 'N'),
	('13', '13/01/2022', '13131106', '1', 'Supply of PPE', '496000', 'N'),
	('14', '14/01/2022', '14141102', '2', 'Vibrating Level Switch', '2220000', 'N'),
	('15', '17/01/2022', '15171100', '8', 'Repair Works on Driver''s Bathroom', '226000', 'N'),
	('16', '17/01/2022', '16171106', '18', 'Rat Repellant Chemical', '3204100', 'N'),
	('17', '17/01/2022', '17171102', '2', 'Supply of Domino Panel AC', '1929408', 'N'),
	('18', '17/01/2022', '18171102', '2', 'PURCHASE OF LNG ANTISTATIC ACCESSORIES', '264000', 'N'),
	('19', '26/05/2022', '19265102', '6', 'Slum Apparatus & Concrete Cube Mould', '402500', 'U'),
	('20', '19/01/2022', '20191102', '2', 'Supply of Insulated Screw Driver', '964000', 'N'),
	('21', '19/01/2022', '21191102', '2', 'Vacuum Pressure Guage', '168000', 'N'),
	('22', '19/01/2022', '22191102', '2', 'Filarc Cast Electrode', '104000', 'N'),
	('23', '19/01/2022', '23191102', '2', '37Kw Danfoss Frequency Converter', '5100000', 'N'),
	('24', '20/01/2022', '24201106', '10', 'Supply of First Aid Items', '336285', 'N'),
	('25', '20/01/2022', '25201101', '64', 'INTEGRITY TESTS FOR TANKS 23 / 24 / 25 / 28 / 69 IN LOBP', '16064500', 'N'),
	('26', '20/01/2022', '26201107', '22', 'HAZOP SERVICES FOR NEW GAS COMPRESSION FACILITIES', '4497900', 'Y'),
	('27', '20/01/2022', '27201108', '2', 'Supply of Micro fridge', '1600000', 'N'),
	('28', '20/01/2022', '28201100', '2', 'Elimination of Effluent smell from Toilets for 3 houses', '900000', 'N'),
	('29', '21/01/2022', '29211102', '2', 'Pipe flaring tool', '45000', 'N'),
	('30', '21/01/2022', '30211103', '2', 'FABRICATION & INSTALLATION OF THE STAINLESS STEEL 304 HAND RAILS', '466500', 'N'),
	('31', '21/01/2022', '31211102', '6', 'Supply of Poker Vibrator', '120000', 'N'),
	('32', '21/01/2022', '32211106', '1', 'Supply of Requested Hand Gloves', '780000', 'N'),
	('33', '21/01/2022', '33211106', '1', 'Supply of PVC Hand gloves', '180000', 'N'),
	('34', '24/01/2022', '34241106', '14', 'MOP Cap', '585000', 'Y'),
	('35', '20/01/2022', '35201101', '64', 'INTEGRITY TESTS AND CALIBRATION OF TANKS 21 / 22 / 27 / 71 IN LOBP', '14518850', 'N'),
	('36', '27/01/2022', '36271103', '2', 'INSTALLATION OF PROTECTIVE BOLLARDS AT PALLETIZER', '6094000', 'N'),
	('37', '27/01/2022', '37271102', '2', 'Supply of Electrical Materials', '951500', 'N'),
	('38', '27/01/2022', '38271106', '2', 'Supply of Reflective Jackets', '2375000', 'N'),
	('39', '27/01/2022', '39271106', '10', 'Supply of PPE Consumables at Ondo Plant', '619000', 'N'),
	('40', '27/01/2022', '40271102', '2', 'Concrete Drilling Machine', '334916', 'N'),
	('41', '27/01/2022', '41271102', '2', 'A/c compressor and refrigerant', '5599083.36', 'N'),
	('42', '27/01/2022', '42271108', '2', 'A-SHAPED STEP LADDER', '43000', 'N'),
	('43', '28/01/2022', '43281106', '65', 'SUPPLY OF Coveralls', '15023400', 'Y'),
	('44', '28/01/2022', '44281106', '81', 'Supply of Dispensable PPEs', '2834000', 'N'),
	('45', '28/01/2022', '45281102', '6', 'Cone Slump Apparatus and Concrete Mould Cone', '382500', 'N'),
	('46', '28/01/2022', '46281106', '1', 'Medical Aprons and Gowns', '82000', 'Y'),
	('47', '02/02/2022', '4722106', '66', 'Supply of Safety Boots', '245500', 'N'),
	('48', '02/02/2022', '4822104', '18', 'Servicing of Fire Extinguishers @JHPP', '1426300', 'N'),
	('49', '02/02/2022', '4922108', '8', 'ToweL, Bedside & Bath Mats', '1056000', 'N'),
	('50', '04/02/2022', '5042104', '67', 'Fire Extinguisher', '35850000', 'N'),
	('51', '04/02/2022', '5142105', '56', 'Preparation of Operational HSE Case Document', '4787000', 'Y'),
	('52', '04/02/2022', '5242106', '2', 'Supply of PPEs', '1420000', 'N'),
	('53', '07/02/2022', '5372106', '18', 'Oil Absorbent Pad for Jebba Plant', '432400', 'N'),
	('54', '07/02/2022', '5472104', '66', 'Fire Extinguisher', '1462800', 'N'),
	('55', '07/02/2022', '5572106', '68', 'Safety Boots', '210000', 'Y'),
	('56', '08/02/2022', '5682104', '18', 'Duraline Hose for Jebba Plant', '20869280', 'N'),
	('57', '09/02/2022', '5792100', '69', 'SHOWROOM RENOVATION WORKS PORTHARCOURT', '30000000', 'Y'),
	('58', '09/02/2022', '5892100', '70', 'PROPOSED RESIDENTIAL DEVELOPMENT OSBOURNE', '600561560', 'N'),
	('59', '10/02/2022', '59102106', '71', 'Supply of PPE', '1422000', 'N'),
	('60', '10/02/2022', '60102106', '2', 'Emergency Eye Shower', '750000', 'N'),
	('61', '10/02/2022', '61102102', '2', 'ASI POWER SUPPLY', '2290000', 'N'),
	('62', '11/02/2022', '62112106', '2', 'Plastic Truck Wedges', '58500', 'N'),
	('63', '12/02/2022', '63122107', '46', 'HIRA Workshop for Ikike Surf Project', '1600000', 'N'),
	('64', '12/02/2022', '64122102', '2', 'LONG 2.5"" FIRE HYDRANT 10BAR HOSE FOR EVACUATION OF SLUDGE', '54000', 'N'),
	('65', '15/02/2022', '65152106', '72', 'Supply of PH3 Gas Tight Suits and Accessories', '50466888', 'N'),
	('66', '12/02/2022', '66122106', '2', 'SAFETY KITS FOR SHADOW BOX (AMA 2A PKG)', '1684000', 'N'),
	('67', '12/02/2022', '67122100', '2', 'CONCRETE SLAB FOR NEW BOILER 4', '4102950', 'N'),
	('68', '10/03/2022', '68103102', '2', '7.5 KW Electric Motor', '510000', 'Y'),
	('69', '16/02/2022', '69162100', '2', 'FPS''s OFFICE RELOVATION PROJECT AT NIGERIAN BREWERIES PLC IBADAN', '8555000', 'N'),
	('70', '16/02/2022', '70162103', '16', 'Warehouse Storage Racking System - Option 2', '26454600', 'U'),
	('71', '18/02/2022', '71182102', '2', 'DVGW PRESSURE REDUCING VALVE', '450650', 'N'),
	('72', '18/02/2022', '72182106', '73', 'Personal Protective Equipment Bid', '213132496.71', 'N'),
	('73', '12/02/2022', '73122106', '74', 'Personal Protective Equipment Bid', '160539500', 'N'),
	('74', '22/02/2022', '74222107', '75', 'External HAZOP Facilitation Service', '103700000', 'U'),
	('75', '21/02/2022', '75212102', '2', 'Polymer Transfer Pump', '1242742.8', 'N'),
	('76', '22/02/2022', '76222102', '2', 'Old Brewery Hydrant Pump', '3510000', 'N'),
	('77', '22/02/2022', '77222103', '2', 'NB window blind creche (addendum)', '124400', 'Y'),
	('78', '22/02/2022', '78222108', '10', 'SCRAPER FOR CANDY', '200000', 'N'),
	('79', '25/02/2022', '79252100', '2', 'CONSTRUCTION OF REINFORCED CONCRETE SHED FOR THE CENTRIFUGE TANKS', '5534269', 'N'),
	('80', '25/02/2022', '80252107', '78', 'TECHNICAL HSE STUDIES for OBAMA Flowstation', '16800000', 'N'),
	('81', '25/02/2022', '81252107', '78', 'TECHNICAL HSE STUDIES for CLOUGH CREEK Flowstation', '16800000', 'N'),
	('82', '25/02/2022', '82252107', '78', 'TECHNICAL HSE STUDIES for BRASS TERMINAL Flowstation', '20200000', 'N'),
	('83', '25/02/2022', '83252101', '2', 'Repair and painting of Accommodation & Annex sliding gates', '4149000', 'N'),
	('84', '02/03/2022', '8423108', '6', 'SUPPLY OF 20MM BY 100YARDS THICK MARINE ROPE', '125000', 'N'),
	('85', '02/03/2022', '8523106', '6', 'SUPPLY OF 10M LADDER', '460000', 'N'),
	('86', '11/03/2022', '86113106', '81', 'Nose Mask and Sterile medical glove', '2634000', 'N'),
	('87', '09/03/2022', '8793102', '1', 'SUPPLY OF PLUMBING ITEMS', '1135000', 'N'),
	('88', '09/03/2022', '8893100', '2', 'Drainage at OEBGH', '1462750', 'N'),
	('89', '04/03/2022', '8943102', '2', 'Swimming pool pump', '424000', 'N'),
	('90', '05/03/2022', '9053108', '2', 'Battery and Charger Starter Pack', '343000', 'N'),
	('91', '11/03/2022', '91113100', '2', 'Toilet construction', '20161800', 'N'),
	('92', '15/03/2022', '92153104', '79', 'Servicing and Refilling of Fire Extinguishers', '7654500', 'N'),
	('93', '15/03/2022', '93153102', '8', 'quotations - plumbing items', '617000', 'Y'),
	('94', '16/03/2022', '94163100', '2', 'Road repair Makurdi brewery', '29596341', 'N'),
	('95', '17/03/2022', '95173104', '18', 'Bi-annual Servicing/Maintenance of Fire Alarm System at Jebba Plant for 2022', '1078500', 'N'),
	('96', '22/03/2022', '96223108', '18', 'Ultrasonic liquid level indicator with calculator', '5201448', 'N'),
	('97', '23/03/2022', '97233108', '20', 'Unmanned Aerial Vehicle-Drone', '1812500', 'N'),
	('98', '03/04/2022', '9834104', '18', 'CERTIFICATION OF WELDING GAS CYLINDERS', '1395800', 'N'),
	('99', '02/04/2022', '9924108', '18', 'SPANNERS AND TOOL BOX', '17451593.6', 'N'),
	('100', '03/04/2022', '10034100', '30', 'ENGINEERING, PROCUREMENT AND CONSTRUCTION OF SECURITY WATCHTOWERS FOR ANOH GAS PLANT PROJECT (AGPC/LAG/ITT/2022/TECH-ANOH/TP022-2022)', '159120300', 'U'),
	('101', '03/04/2022', '10134103', '16', 'Warehouse Storage Racking System - Option 3', '91413700', 'U'),
	('102', '03/04/2022', '10234102', '16', '1.5 Ton Forklift', '6800000', 'U'),
	('103', '02/04/2022', '10324106', '10', 'Wall Mounted Thermometer', '85000', 'N'),
	('104', '29/03/2022', '104293106', '2', '3M FFP3 Nose Mask', '170000', 'Y'),
	('105', '09/04/2022', '10594100', '2', 'Construction of Forklift Mast Suspension', '937166', 'N'),
	('106', '09/04/2022', '10694100', '2', 'Renovation Work: Re-Cladding', '3444800', 'N'),
	('107', '09/04/2022', '10794100', '69', 'Construction of Residential Development', '58000000', 'Y'),
	('108', '07/04/2022', '10874106', '10', 'Disposable Nose Mask', '1197000', 'N'),
	('109', '06/04/2022', '10964106', '18', 'Supply of Safety Items', '8492640', 'N'),
	('110', '20/04/2022', '110204102', '65', 'BATTERY POWERED TOOLS', '1666000', 'U'),
	('111', '29/04/2022', '111294106', '96', 'Rubber Rainboots', '231000', 'U'),
	('112', '29/04/2022', '112294106', '1', 'Handgloves and Glasses', '338000', 'U'),
	('113', '28/04/2022', '113284106', '8', 'Safety Boots', '18924000', 'Y'),
	('114', '25/04/2022', '114254106', '14', 'Nitrile Gloves', '1094000', 'N'),
	('115', '26/04/2022', '115264106', '14', 'Red Hand Glove', '215000', 'N'),
	('116', '22/04/2022', '116224102', '6', 'Power Floating Machine', '1771500', 'Y'),
	('117', '29/04/2022', '117294106', '96', 'Cold Room Jacket', '441500', 'U'),
	('118', '30/04/2022', '118304102', '65', 'Instrument Tools', '37467295.2', 'U'),
	('119', '23/05/2022', '119235102', '97', 'Supply and Installation of Valve and Positioner', '2800000', 'U'),
	('120', '25/05/2022', '120255102', '65', 'Supply of Car Battery Charger and Jump Starter', '209000', 'U'),
	('121', '26/05/2022', '121265106', '14', 'Reflective Jackets', '90000', 'U'),
	('122', '26/05/2022', '122265101', '97', 'Procurement and Installation of Auto-Lifting Winch', '6550000', 'U'),
	('123', '10/05/2022', '123105106', '18', 'Supply of Q1 PPEs to JHPP 2022', '4723250', 'Y'),
	('124', '03/06/2022', '12436108', '97', 'Supply of Plastic Inserts', '4338640', 'U'),
	('125', '02/06/2022', '12526106', '73', 'Supply of PPE', '10545000', 'U'),
	('126', '30/05/2022', '126305101', '97', 'Provision and Installation of Pressure Relief on Overflow Line', '10500000', 'U'),
	('127', '10/06/2022', '127106105', '24', 'Operational HSE Case for Sapele Facilities', '9478000', 'U'),
	('128', '10/06/2022', '128106102', '65', 'Supply of Scaffolding Materials', '11719675', 'U'),
	('129', '10/06/2022', '129106104', '2', 'Upgrade of Fire Detection Systems at HQ Sales Annex', '8613745', 'U'),
	('130', '10/06/2022', '130106108', '2', 'Installation of Addressable Fire System', '5146435', 'U'),
	('131', '28/07/2022', '131287106', '73', 'Supply of Security Protection Material', '244878240', 'U'),
	('132', '07/06/2022', '13276106', '18', 'Supply of M16 Harness PFD Belt', '635000', 'U'),
	('133', '17/06/2022', '133176100', '2', 'Renovation Work: 2 Classroom at TPM Building', '3665646', 'U'),
	('134', '17/06/2022', '134176106', '2', 'Bump Caps', '101200', 'Y'),
	('135', '17/06/2022', '135176106', '10', 'Red Rubber Gloves', '2037500', 'U'),
	('136', '14/06/2022', '136146106', '10', 'Electrical Safety PPE', '61180', 'U'),
	('137', '23/06/2022', '137236106', '45', 'SUPPLY OF RETRACTABLE CONE BAR BARRICADES & BARRIERS', '259400', 'U'),
	('138', '24/06/2022', '138246106', '14', 'SAFETY RAIN BOOT', '70000', 'U'),
	('139', '23/06/2022', '139236106', '2', 'RUBBER SAFETY BOOT', '1995000', 'U'),
	('140', '24/06/2022', '140246104', '18', 'servicing and maintenance of Auto CO2 and FM200 Fire suppression system at Jebba HPP', '2531340', 'Y'),
	('141', '23/06/2022', '141236107', '15', 'SEFLAM/SPDC UZU MANIFOLD PROJECT', '14410000', 'U'),
	('142', '22/06/2022', '142226106', '16', 'Safety Shoes', '924000', 'U'),
	('143', '06/07/2022', '14367107', '22', 'PSSR for Egbaoma 2.0', '6195000', 'Y'),
	('144', '05/07/2022', '14457103', '4', 'Procurement, Civil and Fabrication works and Installation of Material Storage Racks', '21569950', 'U'),
	('145', '04/07/2022', '14547107', '99', 'ASSA NORTH-OHAJI SOUTH PROJECT: INSTALLATION_AND CONSTRUCTION OF 33K_0_4KV TRANSMISSION LINE FOR ASSA NORTH CEIP', '1935000', 'U'),
	('146', '07/07/2022', '14677106', '18', 'Drum Lifting Device at Kainji Plant', '485275', 'U'),
	('147', '08/07/2022', '14787106', '45', 'SUPPLY OF DARLEY NOMEX CHAMPION GEAR (HEAD TO TOE PACKAGE) FIREMEN SUITS.', '27048000', 'U'),
	('148', '08/07/2022', '14887106', '45', 'Supply of Dupont Disposable Tyvek', '7355000', 'U'),
	('149', '07/07/2022', '14977106', '18', 'Little Giant Ladder at Kainji Plant', '3131700', 'U'),
	('150', '08/07/2022', '15087106', '14', 'Surgical Gloves', '807000', 'U'),
	('151', '08/07/2022', '15187106', '2', 'Supply of PPEs', '912150', 'U'),
	('152', '08/07/2022', '15287104', '18', 'Servicing and Maintenance of Fire Alarm at KHPP', '608600', 'Y'),
	('153', '08/07/2022', '15387105', '62', 'Addendum to Ata-6 Field HSE Case', '5376000', 'U'),
	('154', '19/07/2022', '154197106', '45', 'Supply of Stock-Out Items for 20 First Aid Boxes Strategically Located Within the Plant.', '683600', 'U'),
	('155', '20/07/2022', '155207107', '100', 'Seplat Energy Flaredown Project Paarticipation', '1458000', 'U'),
	('156', '15/07/2022', '156157103', '4', 'EXTENSION CONCRETE BASE FOR THE CONTAINER OF PEPSICO', '913100', 'U'),
	('157', '22/07/2022', '157227106', '45', 'Portwest Biz-weld Coveralls', '71922240', 'U');

insert into orders
values
('1', '30/12/2021', '3', 'Refilling of Fire Extinguishers at Wuse-2 Branch', '123000'),
	('2', '08/01/2022', '63', 'CIVIL CONSTRUCTION WORKS-CONCRETE FLOOR FOR CONTAINER', '1029250'),
	('3', '18/01/2022', '14', 'Cold Room Jacket', '1116000'),
	('4', '19/01/2022', '14', 'MOP Cap', '252000'),
	('5', '26/01/2022', '1', 'Supply of Items for First Aid Box', '401762.5'),
	('6', '28/01/2022', '22', 'HAZOP SERVICES FOR NEW GAS COMPRESSION FACILITIES', '4497900'),
	('7', '31/01/2022', '1', 'Supply of Medical Apron and Gown', '82000'),
	('8', '04/02/2022', '56', 'Preparation of Operational HSE Case Document', '4787000'),
	('11', '23/02/2022', '65', 'Supply of Coveralls', '15023400'),
	('12', '09/03/2022', '8', 'fabrication of FM200 cylinder shed', '745350'),
	('13', '04/03/2022', '2', 'Window Blinds project', '121600'),
	('14', '11/03/2022', '16', 'Supply of 42pairs Dills Alpha', '808800'),
	('15', '06/02/2022', '24', 'HAZOP of Okpohuru-Orogho GLCC Installation and Gas Lift Project', '3103000'),
	('16', '22/03/2022', '14', 'chemical resistant rubber handgloves', '15600'),
	('17', '02/04/2022', '2', '3M FFP3 Nose Mask', '170000'),
	('18', '11/04/2022', '2', '7.5 KW Electric Motor', '510000'),
	('19', '20/04/2022', '69', 'SHOWROOM RENOVATION WORKS PORTHARCOURT', '30000000'),
	('20', '20/04/2022', '69', 'Construction of Residential Development', '58000000'),
	('21', '22/04/2022', '8', 'quotations - plumbing items', '617000'),
	('22', '29/04/2022', '68', 'Echo Dills Safety Boots', '210000'),
	('23', '04/05/2022', '6', 'Power Floating Machine', '1771500'),
	('24', '04/05/2022', '8', 'Safety Boots', '18924000'),
	('25', '01/06/2022', '18', 'Supply of Q1 PPEs to JHPP 2022', '4723250'),
	('26', '28/06/2022', '14', 'Raincoats', '20500'),
	('27', '05/07/2022', '14', 'MOP Caps - 20 Cartons', '390000'),
	('28', '05/07/2022', '65', 'Eye goggles and Helmet', '1792000'),
	('29', '06/07/2022', '8', 'Repair works on trolley and bed', '402800'),
	('30', '14/07/2022', '14', 'MOP Caps - 10 Cartons', '195000'),
	('31', '15/07/2022', '18', 'SERVICE AND MAINTENANCE OF AUTOMATIC CO2 AND FM-200 AT JEBBA POWER PLANT', '2531340'),
	('32', '16/07/2022', '22', 'PSSR for Egbaoma 2.0', '6195000'),
	('33', '17/07/2022', '8', 'TOTAL PPR Plastic Tube Welding machine', '55000'),
	('34', '18/07/2022', '24', 'Forcados Terminal Re-HAZOP', '13463091.18'),
	('35', '22/07/2022', '2', '23pcs of Bump Cap', '101200'),
	('36', '23/07/2022', '18', 'Servicing and Maintenance of Fire Alarm at KHPP', '608600'),
	('37', '24/07/2022', '14', 'MOP Caps - 10 Cartons', '195000');



-- Quantitative Analysis on the 'tesil' database
select * from clients;

--CLIENTS
	-- No of Clients:
	select count(distinct client_id) as "no of clients" from clients;

	-- No of Clients with Rfx:
	select count(distinct rfx.client_id) as "no of clients",
	count(distinct rfx.client_id) * 100.00 / sum(count(distinct clients.client_id)) over() as "%_of total client"
	from rfx
	full join clients on rfx.client_id = clients.client_id;

	-- Client with high no. of rfx"
	select clients.client_name as client, count(rfx.rfx_id) as "no. of rfx"
	from clients
	left join rfx on clients.client_id = rfx.client_id
	group by clients.client_name
	having count(rfx.rfx_id) >= 5
	order by 2 desc;

	-- No of Clients with Orders:
	select count(distinct orders.client_id) as "no of clients",
	count(distinct orders.client_id) * 100.00 / sum(count(distinct clients.client_id)) over() as "%_of total client"
	from orders
	full join clients on orders.client_id = clients.client_id;

	
--RFX
	-- No fo Rfx:
	select count(distinct rfx_id) as "no of rfx" from rfx;

	-- Total, Average, Minimum, Maximun and Range of Rfx Value:
	select sum(rfx_value) as "total rfx value", avg(rfx_value) as "average rfx value",
	max(rfx_value) as "max rfx value", min(rfx_value) as "minimum rfx value",
	(max(rfx_value) - min(rfx_value)) as "rfx value range"
	from rfx;

	-- Total no. of rfx and rfx value by clients:
	--i. ordered by no of rfx:
	select client_name as client, count(r.client_id) as "No of Rfx", count(r.rfx_id) *100.00 / sum(count(r.rfx_id)) over () as "% of total no. of rfx",
	sum(r.rfx_value) as "total rfx value"
	from clients c
	left join rfx r on c.client_id = r.client_id
	where r.rfx_value > 0
	group by client_name
	order by 2 desc;

	--ii. ordered by rfx value:
	select client_name as client, count(r.client_id) as "No of Rfx",
	sum(r.rfx_value) as "total rfx value", sum(r.rfx_value) *100.00 / sum(sum(r.rfx_value)) over() as "% of overall total rfx value"
	from clients c
	left join rfx r on c.client_id = r.client_id
	where r.rfx_value > 0
	group by client_name
	order by 3 desc;

	

--ORDERS
	-- No of Orders:
	select count(distinct order_id) as "no of orders" from orders;

	-- Total, Average, Minimum, Maximun and Range of Orders Value:
	select format(sum(order_value),'c','ig-NG') as "total order value", format(avg(order_value),'c','ig-NG') as "average order value",
	format(max(order_value),'c','ig-NG') as "max order value", format(min(order_value),'c','ig-NG') as "minimum order value",
	format((max(order_value) - min(order_value)),'c','ig-NG') as "order value range"
	from orders;


	-- Total no. of orders and orders value by clients:
	--i. ordered by no of order:
	select client_name as client, count(o.client_id) as "No of Order", count(o.order_id) *100.00 / sum(count(o.order_id)) over () as "% of total no. of order",
	sum(o.order_value) as "total order value"
	from clients c
	left join orders o on c.client_id = o.client_id
	where o.order_value > 0
	group by client_name
	order by 2 desc;

	--ii. ordered by order value:
	select client_name as client, count(o.client_id) as "No of Order",
	sum(o.order_value) as "total order value", sum(o.order_value) *100.00 / sum(sum(o.order_value)) over() as "% of overall total order value"
	from clients c
	left join orders o on c.client_id = o.client_id
	where o.order_value > 0
	group by client_name
	order by 3 desc;


-- BUSINESS SECTOR:
select * from clients;
select * from rfx;
select * from orders;

--ok
	select distinct count(r.rfx_id) as "no. of rfx", c.business_sector,
	sum(r.rfx_value) as "total rfx value", sum(r.rfx_value)*100.00 / sum(sum(r.rfx_value)) over() as "% of overall rfx total"
	from clients c
	left join rfx r on c.client_id = r.client_id
	group by c.business_sector
	order by 1 desc;

--ok
	select distinct count(o.order_id) as "no of orders", c.business_sector,
	sum(o.order_value) as "total order value", sum(o.order_value) / sum(sum(o.order_value)) over() as "% of overall orders total"
	from clients c
	left join orders o on c.client_id = o.client_id
	group by c.business_sector
	order by 1 desc;