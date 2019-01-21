import org.gicentre.geomap.*;
import org.gicentre.utils.colour.*;
import org.gicentre.utils.gui.*;    // For tooltips

GeoMap geoMap;

ColourTable cTableMap;  

color minColour = color(222, 235, 247);
color maxColour = color(49, 130, 189); 

color landColor = color(255,255,255);
color boundaryColour = uiColor4;

int mapX, mapY, mapW, mapH;

Tooltip tooltip;
PImage mapLegendImage;

void setupMap(int x, int y, int w, int h) {  
  
  mapX = x;
  mapY = y;
  mapW = w;
  mapH = h;
  
  //geoMap = new GeoMap(this);
  geoMap = new GeoMap(mapX, mapY, mapW, mapH, this); // Create the map object to cover a part of the sketch
  geoMap.readFile("world");   // Read shapefile.
  //geoMap.writeAttributesAsTable(0);
  
  cTableMap = ColourTable.getPresetColourTable(ColourTable.BR_B_G, -5, 5);
  mapLegendImage = loadImage("mapLegend.png"); 
}

void drawMap() {

  stroke(boundaryColour);              
  strokeWeight(0.5);
  fill(landColor); //land colour
  geoMap.draw("^(?!ATA).*$", 2);  // leave antarctica out

  int selectedYear = years[selectedYearIndex];
  Iterable<TableRow> rowsForYear = tableHCImport.findRows(String.valueOf(selectedYear), "year");
  String tooltipText = "";
  int mouseID = -1;
  
  for (TableRow countryRowPerYear : rowsForYear) {
    float hcNetImport = countryRowPerYear.getFloat("total_netHCimport");
    String countryName = countryRowPerYear.getString("country").trim();
    
    if(countryName.equals("Other")) {
      continue;
    }
    
    TableRow geoMapAttributeRow = geoMap.getAttributeTable().findRow(countryName,"NAME");
    if(geoMapAttributeRow == null) {
      println("Cannot find: " + countryName + " in geoMap attribute table. Skipping country.");
      continue;
    }
    
    int geoMapCountryId = geoMapAttributeRow.getInt("id");
    float binnedValue = binValue(hcNetImport);

    //fill(lerpColor(minColour, maxColour, normOilImp));
    fill(cTableMap.findColour(-binnedValue));  //(-normOilImp) to reverse the color scale (blue for minus i.e. export, red for plus i.e import)
    
    geoMap.draw(geoMapCountryId);
     
    // Set tooltip text if mouse is over this country
    mouseID = geoMap.getID(mouseX, mouseY);
    if (mouseID == geoMapCountryId)
    {
      tooltipText = countryName + ": " + String.format("%.2f", abs(hcNetImport)) + "mmtoe"; 
    }
    
  }
  
  // Draw tooltip
  if(mouseID != -1 && tooltipText != ""){
    fill(0);
    stroke(0);
    rect(mouseX + 5, mouseY - 24, textWidth(tooltipText) + 10, 20, 4);
    fill(255);
    text(tooltipText, mouseX+10, mouseY-10);
  }

  // Write map title
  drawMapTitle();
  
  drawMapLegend();
  
}

float binValue(float value) {
  float [] positiveBinValues = {20, 5, 1, 0.1, 0};
  float [] positiveBins = {5, 4 , 3, 2, 1};
  
  float [] negativeBinValues = {0, -0.5, -1, -5, -10};
  float [] negativeBins = {-1, -2, -3, -4, -5};
  
  if (value > 0) {
    for(int i = 0; i < positiveBinValues.length; i++){
      if(value > positiveBinValues[i]) {
        return positiveBins[i];
      }
    }
  } else if (value < 0) {
     for(int i = negativeBinValues.length - 1; i >= 0; i--){
      if(value < negativeBinValues[i]) {
        return negativeBins[i];
      }
    }
  }
  return 0;
}

void drawMapLegend() {
  // Draw the legend
  float imgW = mapLegendImage.width/4;
  float imgH = mapLegendImage.height/4;
  float imgX = mapX + mapW - 20;
  float imgY = mapY + mapH / 2 - imgH;
  
  float lineHeight = imgH / 10;
  
  image(mapLegendImage, imgX, imgY, imgW, imgH);
  
  textSize(10);
  textAlign(TOP, LEFT);
  text("import", imgX , imgY - 5);
  text("export", imgX , imgY + 11 * lineHeight );
  
  text("> 20", imgX + imgW + 2, imgY + 10);
  text("5-20", imgX + imgW + 2, imgY + 22); 
  text("1-5", imgX + imgW + 2, imgY + 34);
  text("0.1-1", imgX + imgW + 2, imgY + 46);
  text("0-0.1", imgX + imgW + 2, imgY + 58);
  text("0 net", imgX + imgW + 2, imgY + imgH/2 + 4);
  text("0-0.5", imgX + imgW + 2, imgY + imgH/2 + 16);
  text("0.5-1", imgX + imgW + 2, imgY + imgH/2 + 28);
  text("1-5", imgX + imgW + 2, imgY + imgH/2 + 40);
  text("5-10", imgX + imgW + 2, imgY + imgH/2 + 52);
  text("> 10", imgX + imgW + 2, imgY + imgH - 2);
}

void drawMapTitle() {
  textSize(chartHeadingTextSize);
  fill(textColor2);
  textAlign(CENTER);
  text("With which countries UK traded Fossil Fuels in " + years[selectedYearIndex] +" ?", mapX + mapW / 2, mapY - 20);
 
  textSize(10); //(chartSubhedingTextSize);
  fill(textColor2);
  text("(UK net exports in green, net imports in brown, mmtoe)",  mapX + mapW / 2, mapY - 8);
}
