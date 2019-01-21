
color oilColor = color(200,150,120); //(160, 119, 49);
color ngColor = color(144,153,104); // (204,191,66); //(222, 173, 59);
color coalColor = color(102, 102, 102);

float barThickness = 20; 

float domainMin = 0;
float domainMax = 110;

void drawFossilFuelSufficiencyChart(int chartX, int chartY, int chartW, int chartH) {
  //draw chart border and background
  //stroke(chartBorderColor);
  //fill(chartFillColor);
  //rect(chartX, chartY, chartW, chartH);
  

  //draw the verical line for import-production and export-production distinction
  int ymap = chartW / 3;
  
  int exportLineX = chartX + ymap;
  int exportLineY = chartY;
  int importLineX = exportLineX + ymap;
  int importLineY = chartY;
  
  float baseBarY = chartY + chartHeadingHeight + 10;
  
  //draw chart heading 
  fill(textColor2);
  textAlign(CENTER);
  textSize(chartHeadingTextSize);
  text("UK Self-sufficiency for Fossil Fuels in " + years[selectedYearIndex], chartX + chartW / 2, chartY - 50);
  
  textSize(10);
  text("After 2003, UK became dependent on net fossil fuel imports.", chartX + chartW / 2, chartY - 37); 
  
  //draw area labels
  textSize(chartSubhedingTextSize);
  text("Exporting", chartX + ymap/2, chartY + 24); 
  text("Self-sufficient", exportLineX + ymap/2 +3, chartY + 24); 
  text("Importing", importLineX + ymap/2, chartY + 24); 
  
  drawSufficiencyChartLegend(chartX, chartY, chartW);
  
  stroke(textColor1);
  //rect(chartX, chartY + chartHeadingHeight, chartW , 1);
  
  int year = selectedYearIndex; // 0 means date[0], i.e. 2000;
  
  // natural gas rectangles
  fill(ngColor);
  stroke(ngColor);
  if (ngNetImpot[year] < 0) 
  {   // UK exported more, max value on the table = 99 (on ng_cons column)
    float ng_nexp_bar = map(-ngNetImpot[year], 0, domainMax, 0, ymap);
    float ng_cons_bar = map(ngConsumption[year], 0, domainMax, 0, ymap);
    rect(exportLineX, baseBarY, ng_cons_bar, barThickness);
    strokeWeight(2);
    stroke(0);
    rect(exportLineX - ng_nexp_bar, baseBarY, ng_nexp_bar, barThickness);
    fill(0);
    text(String.format("%.1f", -ngNetImpot[year]) +"mmtoe", exportLineX - ng_nexp_bar - 55, baseBarY+3); 
  } 
  else
  {   // UK imported more, max value on the table = 99 (on ng_cons column)
    float ng_prodcons_bar = map(ngConsumption[year]-ngNetImpot[year], 0, domainMax, 0, ymap);
    float ng_nimp_bar = map(ngNetImpot[year], 0,domainMax, 0, ymap);
    rect(importLineX - ng_prodcons_bar, baseBarY, ng_prodcons_bar, barThickness);
    strokeWeight(2);
    stroke(0);
    rect(importLineX, baseBarY, ng_nimp_bar, barThickness);
    fill(0);
    text(String.format("%.1f", ngNetImpot[year]) +"mmtoe", importLineX + ng_nimp_bar +5, baseBarY+3);
  }
 
 // oil rectangles
  fill(oilColor);
  stroke(oilColor);
  if (oilNetImport[year]<0) 
  {   // UK exported more, max value on the table = 99 (on ng_cons column)
    float o_nexp_bar = map(-oilNetImport[year], 0, domainMax, 0, ymap);
    float o_cons_bar = map(oilConsumption[year], 0, domainMax, 0, ymap);
    rect(exportLineX, baseBarY+(2*barThickness), o_cons_bar, barThickness);
    strokeWeight(2);
    stroke(0);
    rect(exportLineX - o_nexp_bar, baseBarY+(2*barThickness), o_nexp_bar,barThickness);
    fill(0);
    text(String.format("%.1f", -oilNetImport[year]) +"mmtoe", exportLineX - o_nexp_bar - 60, baseBarY+(2*barThickness)+3);
  } 
  else
  {   // UK imported more, max value on the table = 99 (on ng_cons column)
    float o_prodcons_bar = map(oilConsumption[year]-oilNetImport[year], 0, domainMax, 0, ymap);
    float o_nimp_bar = map(oilNetImport[year], 0, domainMax, 0, ymap);
    rect(importLineX - o_prodcons_bar, baseBarY+(2*barThickness), o_prodcons_bar, barThickness);
    strokeWeight(2);
    stroke(0);
    rect(importLineX, baseBarY+(2*barThickness), o_nimp_bar, barThickness);
    fill(0);
    text(String.format("%.1f", oilNetImport[year]) +"mmtoe", importLineX + o_nimp_bar +5, baseBarY+(2*barThickness)+3);
  }
    
// coal rectangles
  fill(coalColor);
  stroke(coalColor);
  if (coalNetImport[year]<0) 
  {   // UK exported more, max value on the table = 99 (on ng_cons column)
    float c_nexp_bar = map(-coalNetImport[year], 0, domainMax, 0, ymap);
    float c_cons_bar = map(coalConsumption[year], 0, domainMax, 0, ymap);
    rect(exportLineX - c_nexp_bar, baseBarY+(4*barThickness), c_nexp_bar,barThickness);
    rect(exportLineX, baseBarY+(4*barThickness), c_cons_bar, barThickness);
  } 
  else
  {   // UK imported more, max value on the table = 99 (on ng_cons column)
    float c_prodcons_bar = map(coalConsumption[year]-coalNetImport[year], 0, domainMax, 0, ymap);
    float c_nimp_bar = map(coalNetImport[year], 0, domainMax, 0, ymap);
    rect(importLineX - c_prodcons_bar, baseBarY+(4*barThickness), c_prodcons_bar, barThickness);
    strokeWeight(2);
    stroke(0);
    rect(importLineX, baseBarY+(4*barThickness), c_nimp_bar, barThickness);
    fill(0);
    text(String.format("%.1f", coalNetImport[year]) +"mmtoe", importLineX + c_nimp_bar +5, baseBarY+(4*barThickness)+3);
  } 

  //replot the vertical lines
  stroke(60); //(uiColor4);
  rect(exportLineX, exportLineY, 1, chartH - chartHeadingHeight);
  rect(importLineX, importLineY, 1, chartH - chartHeadingHeight);
}

void drawSufficiencyChartLegend(int chartX, int chartY, int chartW) {
   textSize(chartLegendTextSize);
   textAlign(LEFT, TOP);
   // fossil fuel production bar legend
   int legendBoxWidth = chartW/30;
   int legendItemWidth = legendBoxWidth + 5 + 30;
   int legendStartX = chartX+(chartW-legendItemWidth*3)/2 + 8;
   
   int legendBoxHeight = legendBoxWidth;
   int legendTextStartX = legendStartX + legendBoxWidth + 5;
   int legendStartY = chartY - 20;
   
   
   fill(ngColor);//set the rect color to fossil prod bar color
   stroke(ngColor); // set the legend box line to white (or whatever the background is)
   rect(legendStartX, legendStartY, legendBoxWidth, legendBoxHeight);
   fill(60); // (textColor2);//set the text color to black
   text("gas", legendTextStartX , legendStartY);
   
   // fossil fule production bar legend
   fill(oilColor);//set the rect color to fossil prod bar color
   stroke(oilColor); // set the legend box line to white (or whatever the background is)
   rect(legendStartX + legendItemWidth, legendStartY, legendBoxWidth, legendBoxHeight);
   fill(60); //(textColor2);//set the text color to black
   text("oil", legendTextStartX + legendItemWidth, legendStartY);
   
   //line chart legend
   fill(coalColor);//set the rect color to bar (demand) color
   stroke(coalColor); // set the legend box line to white (or whatever the background is)
   rect(legendStartX + legendItemWidth * 2, legendStartY, legendBoxWidth, legendBoxHeight);
   fill(60); //(textColor2);//set the text color to black
   text("coal", legendTextStartX + legendItemWidth * 2, legendStartY);

}
