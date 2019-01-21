import org.gicentre.utils.stat.*;    // For chart classes.
import org.gicentre.utils.colour.*;  // For bar chart colour table.
// draws the line and bar charts for UK enrgy consumption and production

BarChart barChart, barChart2;
XYChart lineChart;
float[] colours, colours2; 
            
color fossilColor = color(165,165,120); //(173,87,34);
color nonFossilColor = color(65,140,110);
color consumpLineColor = color(153, 88, 107); //  textColor2;

color fossilHighlightColor = fossilColor + color(20);
color nonFossilHighlightColor = nonFossilColor + color(20);

int barGap = 5;
int pointSize = 5;

int cpChartX;
int cpChartY;
int cpChartW;
int cpChartH; 

void setupProdConsChart(int x, int y, int w, int h)
{
  cpChartX = x;
  cpChartY = y;
  cpChartW = w;
  cpChartH = h;
  
  barChart = new BarChart(this);
  barChart.setData(t_energy_prod);
  
  // color the bar under mouse at a different color
  colours = new float[date.length];
  ColourTable cTable = new ColourTable();
  
  cTable.addDiscreteColourRule(0, fossilColor);  // Normal colour = 0
  cTable.addDiscreteColourRule(1, fossilHighlightColor);  // Highlight colour = 1
  
    // color the bar under mouse at a different color
  colours2 = new float[date.length];
  ColourTable cTable2 = new ColourTable();
  cTable2.addDiscreteColourRule(0, nonFossilColor);  // Normal colour = 0
  cTable2.addDiscreteColourRule(1, nonFossilHighlightColor);  // Highlight colour = 1


  barChart.setBarColour(colours, cTable);
  // create a gap between bars
  barChart.setBarGap(barGap);
  
  // Axis scaling
  barChart.setMinValue(0);
  barChart.setMaxValue(300);
  
  // Axis appearance
  textSize(10);
  //barChart.setBarLabels(new String[] {"2000","2001","2002","2003","2004",
                                      //"2005","2006","2007","2008","2009",
                                      //"2010","2011","2012","2013","2014",
                                      //"2015","2016"});
  //barChart.showCategoryAxis(true);
  barChart.showValueAxis(true);
   
  // stacked bar chart
  barChart2 = new BarChart(this);
  barChart2.setData(nonfossil_prod);
  

  barChart2.setBarColour(colours2, cTable2);
  
  barChart2.setBarGap(barGap);
  
  // Axis scaling
  barChart2.setMinValue(0);
  barChart2.setMaxValue(300);
  
  barChart2.showValueAxis(true);
  //barChart2.showCategoryAxis(true);
  
  // Line chart 
   
  lineChart = new XYChart(this);
  lineChart.setData(date,t_energy_demand);
  // Axis formatting and labels.
  lineChart.showXAxis(false); 
  lineChart.showYAxis(true); 
  lineChart.setMinY(0);
  lineChart.setMaxY(300);
  lineChart.setMinX(1999.5); // required to allign line with bar chart
  lineChart.setMaxX(2016);
  
  lineChart.setYFormat("###,###");  // mmtoe energy
  
  // Symbol colours
  lineChart.setPointColour(consumpLineColor); // not sure if we want this, but if not specified, it plots it anyway
  lineChart.setPointSize(pointSize);
  lineChart.setLineWidth(pointSize);
  lineChart.setLineColour(consumpLineColor);
}
 
// Draws the chart in the sketch
void drawProdConsChart()
{
  textSize(10);
  
  barChart.draw(cpChartX, cpChartY, cpChartW, cpChartH);
  barChart2.draw(cpChartX, cpChartY, cpChartW, cpChartH);
  lineChart.draw(cpChartX, cpChartY, cpChartW, cpChartH);
 
  // x-axis labels
  fill(textColor2);
  textAlign(LEFT, TOP);
  String[] x_labels = {"2000","2001","2002","2003","2004",
                          "2005","2006","2007","2008","2009",
                          "2010","2011","2012","2013","2014",
                          "2015","2016"};     
  
  float xlabel_x = cpChartX+10;     // Location of start of text.
  float xlabel_y = cpChartY+cpChartH+18;
  
  for (String label : x_labels) {
    pushMatrix();
    
    translate(xlabel_x, xlabel_y);
    xlabel_x += 16.5;
    rotate(PI*1.70);
    text(label,0,0);
    popMatrix(); 
  }

   drawProdConsChartLegend();
   drawProdConsChartHeader();
   highlightProductionBar(selectedYearIndex);
}

void drawProdConsChartLegend() {
   textSize(chartLegendTextSize);
   // fossil fuel production bar legend
   int legendStartX = cpChartX+cpChartW-140;
   int legendBoxWidth = cpChartW/25;
   int legendTextStartX = legendStartX + legendBoxWidth + 10;
   int legendStartY = cpChartY;
   
   fill(fossilColor);//set the rect color to fossil prod bar color
   stroke(fossilColor); // set the legend box line to white (or whatever the background is)
   rect(legendStartX, legendStartY, legendBoxWidth, 10);
   fill(textColor2);//set the text color to black
   text("fossil fuel production^", legendTextStartX , legendStartY);
   
   // fossil fule production bar legend
   fill(nonFossilColor);//set the rect color to fossil prod bar color
   stroke(nonFossilColor); // set the legend box line to white (or whatever the background is)
   rect(legendStartX, legendStartY+16, legendBoxWidth, 10);
   fill(textColor2);//set the text color to black
   text("non-fossil fuel production^^", legendTextStartX, legendStartY+14);
   
   //line chart legend
   fill(consumpLineColor);//set the rect color to bar (demand) color
   stroke(consumpLineColor); // set the legend box line to white (or whatever the background is)
   rect(legendStartX, legendStartY+32, legendBoxWidth, 5);
   fill(textColor2);//set the text color to black
   text("total fuel consumption", legendTextStartX, legendStartY+28);
   textSize(8);
   text("^ gas, oil, coal", cpChartX+10, cpChartY+cpChartH+25);
   text("^^ nuclear, wind, hydro, bio fuels", cpChartX+10, cpChartY+cpChartH+35);
}

void drawProdConsChartHeader(){
   textAlign(CENTER);
   // Draw a title over the top of the chart.
   fill(textColor2);
   textSize(chartHeadingTextSize);
   text("UK Energy Production and Consumption", cpChartX + cpChartW / 2 , cpChartY - 30);
   textSize(10);
   text("million tonnes of oil equivalent (mmtoe) ", cpChartX + cpChartW / 2, cpChartY - 18);
}

void highlightProductionBar(int selectedIndex){
  for (int i=0; i<date.length; i++)
  {
    colours[i] = 0;
    colours2[i] = 0;
  }
  colours[selectedIndex] = 1;
  colours2[selectedIndex] = 1;
  loop();
}
