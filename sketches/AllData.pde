int[] years;
int count;

float[] date, t_energy_demand, t_energy_prod, fossil_prod, nonfossil_prod;
float[] coalConsumption, oilConsumption, ngConsumption, nuclearConsumption, renewableConsumption, netElectricImport, totalEnergyConsumption, oilNetImport, ngNetImpot, coalNetImport;

Table tableOilImport, tableHCImport;
// tableGasImport, tableGasExport, tableOilExport, tableLNGImport, tableCoalImpExp, 
  
void loadData()
{
  // Load the data 
  Table table = loadTable("Processing_input2_mmtoe.csv","csv,header");
  count = table.getRowCount();
  
  years = new int[table.getRowCount()];
  coalConsumption  = new float[table.getRowCount()];
  oilConsumption = new float[table.getRowCount()];
  ngConsumption = new float[table.getRowCount()];
  nuclearConsumption = new float[table.getRowCount()];
  renewableConsumption = new float[table.getRowCount()];
  netElectricImport = new float[table.getRowCount()];
  totalEnergyConsumption = new float[table.getRowCount()];
  oilNetImport = new float[table.getRowCount()]; 
  ngNetImpot =  new float[table.getRowCount()];
  coalNetImport = new float[table.getRowCount()];
  
  date = new float[table.getRowCount()];
  t_energy_demand      = new float[table.getRowCount()];
  t_energy_prod      = new float[table.getRowCount()];
  fossil_prod = new float[table.getRowCount()];
  nonfossil_prod = new float[table.getRowCount()];
  
  for (int row=0; row<table.getRowCount(); row++)
  {
    years[row]      = table.getInt(row, "year");
    coalConsumption[row] = table.getFloat(row, " Coal consumption");
    oilConsumption[row]  = table.getFloat(row, "Petroleum  consumption");
    ngConsumption[row]   = table.getFloat(row, "Natural gas consumption");
    nuclearConsumption[row]  = table.getFloat(row, " Nuclear electricity consumption");
    renewableConsumption[row]     = table.getFloat(row, " Wind and Hydro electricity consumption")+table.getFloat(row, " Bioenergy_and_waste");
    netElectricImport[row] = table.getFloat(row, " Net electricity imports");
    totalEnergyConsumption[row] = coalConsumption[row] + oilConsumption[row] + ngConsumption[row] + nuclearConsumption[row] + renewableConsumption[row] + netElectricImport[row];
    oilNetImport[row] = table.getFloat(row, "oil import") - table.getFloat(row, "oil export");
    ngNetImpot[row] = table.getFloat(row, "NG_LNG import") - table.getFloat(row, "NG export");
    coalNetImport[row] = table.getFloat(row, "coal import") - table.getFloat(row, "coal export");
    
    date[row]      = table.getFloat(row, "year");
    t_energy_demand[row]     = table.getFloat(row, "Total consumption");
    t_energy_prod[row]     = table.getFloat(row, "Total energy production");
    fossil_prod[row] = table.getFloat(row, "coal prod") + table.getFloat(row, "oil prod") + table.getFloat(row, "NG prod");
    nonfossil_prod[row] = table.getFloat(row, " Nuclear electricity consumption") + table.getFloat(row, " Wind and Hydro electricity consumption") + table.getFloat(row, " Bioenergy_and_waste");
  }
  
  tableOilImport = loadTable("crudeImport_2000-2016_mmtoe.csv","csv,header"); 
  tableHCImport = loadTable("OilGasCoalNetimp_byCountry_2000-2016_mmtoe.csv","csv,header"); 
  //tableOilExport = loadTable("crudeExport_2000-2016_mmtoe.csv","csv,header"); 
  //tableGasExport = loadTable("gasExport_2000-2016_mmtoe.csv","csv,header");
  //tableGasImport = loadTable("gasImport_2000-2016_mmtoe.csv","csv,header");
  //tableLNGImport = loadTable("LNGimport_2000-2016_mmtoe.csv","csv,header");
  //tableCoalImpExp = loadTable("coalImpExp_2000-2016_mmtoe.csv","csv,header");
  
 
}
