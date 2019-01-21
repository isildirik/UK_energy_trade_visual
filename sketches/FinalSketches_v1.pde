int selectedYearIndex = 0;

color uiColor1 = #ffffff;
color uiColor2 = #f4f7fb;
color uiColor3 = #dfe3e6;
color uiColor4 = #8897a2;
color uiColor5 = #5a6872;

color textColor1 = #152934;
color textColor2 = #5a6872; 
color textColor3 = #cdd1d4;
color textColorInverse = #ffffff;

color backgroundColor = uiColor1;
color chartBorderColor = uiColor3;
color chartFillColor = uiColor2;

color oceanColor = color(208,222,228); //(176,196,218); //

int chartHeadingHeight = 40;
int chartHeadingTextSize = 16;
int chartSubhedingTextSize = 14;
int chartLegendTextSize = 10;

PFont regularFont;
PFont lightFont;

void setup()
{
  size(1280, 750);

  lightFont = createFont("OpenSans-Light", 64);
  regularFont = createFont("OpenSans-Regular", 32);
  textFont(regularFont);
  
  background(backgroundColor);
  loadData();
  
  setupMap(380, 290, 860, 500);
  setupProdConsChart(50, 140, 300, 220);
  setupYearSelector((width - 17*52) / 2, height - 40, years);
  
  noLoop();
}

void draw()
{  
   background(oceanColor); // ocean colour
   drawMap();
   
   drawProdConsChart();
   drawYearSelector();
  
  drawFossilFuelSufficiencyChart(20, 500, 390, 200);
  
  drawSketchTitle();
  drawKeyInformation();
 
}

void drawSketchTitle() {
  fill(#5a6872);
  rect(0, 0, width, 50);
  
  String sketchTitle = "UK Dependency on Fossil Fuel Imports";
  textSize(20);
  fill(textColorInverse);
  text(sketchTitle, 15, 14);
  
  String sketchDescription = "Explore how the UK's energy production and consumption changed over years alongside the import/export balance for fossil fuels.";
  textSize(11);
  fill(textColorInverse);
  float descriptionWidth = textWidth(sketchDescription);
  text(sketchDescription, width - descriptionWidth - 15, 11);
  
  String sketchGuide = "Use arrow keys or the year selector at the bottom of screen for selecting years.";
  textSize(11);
  fill(textColorInverse);
  float guideWidth = textWidth(sketchGuide);
  text(sketchGuide, width - guideWidth - 15, 27);
}

void drawKeyInformation() {
  int infoY = 110;
  int infoR = 35;
  
  textAlign(TOP);
  
  String yearText = String.valueOf(years[selectedYearIndex]);
  fill(textColor1);
  textFont(lightFont, 64);
  text(yearText, width - textWidth(yearText) - infoR, infoY);
  
  String importExportPrefix = "UK was a net energy ";
  String importExportText;
  if(t_energy_demand[selectedYearIndex] < t_energy_prod[selectedYearIndex]) {
    importExportText = "exporter";
    fill(color(0,60,48)); //(#5aaafa);
  } else {
    importExportText = "importer";
    fill(color(83,48,11)); //(#e0182d);
  }
  textFont(regularFont, 18);
  text(importExportText, width - textWidth(importExportText) - infoR, infoY + 20);
  fill(textColor2);
  text(importExportPrefix, width - textWidth(importExportText) - textWidth(importExportPrefix) - infoR, infoY + 20);
  
  String totalConsumptionPrefix = "Energy consumption: ";
  String totalConsumptionValue = String.valueOf(t_energy_demand[selectedYearIndex]);
  String totalConsumptionSuffix = " mmtoe";
  textFont(regularFont, 10);
  fill(textColor2);
  float textX = width - textWidth(totalConsumptionSuffix);
  text(totalConsumptionSuffix, textX - infoR, infoY + 60);
  
  textFont(regularFont, 32);
  fill(textColor1);
  textX = textX - textWidth(totalConsumptionValue);
  text(totalConsumptionValue, textX - infoR, infoY + 60);
  
  textFont(regularFont, 18);
  fill(textColor1);
  textX = textX - textWidth(totalConsumptionPrefix);
  text(totalConsumptionPrefix, textX - infoR, infoY + 60);
  
  String totalProductionPrefix = "Energy production: ";
  String totalProductionValue = String.valueOf(t_energy_prod[selectedYearIndex]);
  String totalProductionSuffix = " mmtoe";
  textFont(regularFont, 10);
  fill(textColor2);
  textX = width - textWidth(totalProductionSuffix);
  text(totalProductionSuffix, textX - infoR, infoY + 95);
  
  textFont(regularFont, 32);
  fill(textColor1);
  textX = textX - textWidth(totalProductionValue);
  text(totalProductionValue, textX - infoR, infoY + 95);
  
  textFont(regularFont, 18);
  fill(textColor1);
  textX = textX - textWidth(totalProductionPrefix);
  text(totalProductionPrefix, textX - infoR, infoY + 95);
  
  textFont(regularFont, 12);
}
