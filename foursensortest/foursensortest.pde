// The following short CSV file is parsed 
// in the code below. It must be in the project's "data" folder.

Table table;    //table object for organizing date
int ihour = 7;
int iminute = 30;
int hour;
int minute;
float mnts;
int initialtime = 5590;
int totaltime = 37710857;
int bg = 0;
float bgScaled;
int oppbg = 255;
float oppScaled;
float currbg;
boolean first = true;
boolean changetime = false;
int prevtime;
int currtime;
ArrayList<People> people;

void setup() {

  size(1200, 300);
  background(0);
  rectMode(CENTER);
  textSize(25);
  table = loadTable("soundlev.csv");
  people = new ArrayList<People>();
  
}

void draw() {
  //making the background change with time
  bg = mouseX;
  oppbg = mouseX;
  bgScaled = map(bg, 0, width/2, 0, 255);
  oppScaled = map(oppbg, width/2, width, 0, 255);
  if (mouseX < width/2)
  {
    background(bgScaled);
    currbg = bgScaled;
  } 
  else
  {
    background(255 - oppScaled);
    currbg = (255 - oppScaled);
  } 
  for (int i = people.size() - 1; i >= 0; i--) //goes through the array
  {
    People person = people.get(i); //for each specific person
    person.display(); //display it
    person.streak(); //make it drop
    person.checkPosition(); //stop if at end
  }
  fill(255-currbg);
  //clock
  mnts = map(bg, 0, width, (initialtime/60000), (totaltime/60000));
  hour = ihour + floor(mnts/60);
  if ((iminute + floor(mnts)) == 60)
  {
    first = false;
  }
  if (first)
  {
    minute = iminute + floor(mnts % 60);
  } else
  {
    minute = floor(mnts % 60);
  }
  if (hour < 10)
  {
    text(hour, 10, 30);
  } else
  {
    text(hour, -2, 30);
  }
  text(":", 28, 30);
  if (minute < 10)
  {
    text("0", 35, 30);
    text(minute, 50, 30);
  } else
  {
    text(minute, 35, 30);
  }
  //doors
  stroke(2);
  fill(255);
  rect(width/12, height/2, width/12, width/24);
  rect(11* width/12, height/2, width/12, width/24);
  rect(width/2, height/2, width/12, width/24);
  rect(3.5*width/12, height/2, width/120, width/24);
  rect(8.5*width/12, height/2, width/120, width/24); 

  for (TableRow row : table.rows ()) {

    float time = row.getFloat(0);          //define parameter = column 
    float sensor1 = row.getFloat(1);          //define parameter = column 
    float sensor2 = row.getFloat(2);
    float sensor3 = row.getFloat(3);
    float sensor4 = row.getFloat(4);

    //-----scale the data-----

    float timeScaled = map(time, initialtime, totaltime, 0, width); 
    float sensor1Scaled = map(sensor1, 0, 110, 10, 180);
    float sensor2Scaled = map(sensor1, 0, 110, 10, 180);
    float sensor3Scaled = map(sensor1, 0, 110, 10, 180);
    float sensor4Scaled = map(sensor1, 0, 110, 10, 180);
    currtime = mouseX;
    if (currtime != prevtime)
    {
      changetime = true;
    }
    else
    {
      changetime = false;
    }

    if (round(timeScaled) == mouseX && (changetime))
    {
      if (sensor4 > 400)
      {
        people.add(new People((random(33*width/160 - 70, 33*width/160 + 70)), (height/2) - 55, 5, 2.5));
    }
      if (sensor3 > 400)
      {
          people.add(new People(random((181*width/480 - 70), (181*width/480 + 70)), (height/2) - 55, 5, 2.5));
      }
      if (sensor2 > 400)
      {
        people.add(new People(random((299*width/480 - 70), (299*width/480 + 70)), (height/2) - 55, 5, 2.5));
      }
      if (sensor1 > 400)
      {
        people.add(new People(random((127*width/160 - 70), (127*width/160 + 70)), (height/2) - 55, 5, 2.5));
      }
      prevtime = mouseX;
    }
  }
}

class People
{
  PVector position;
  int size;
  float speed;
  People(float x, float y, int tempsize, float tempspeed)
  {
    position = new PVector(x, y);
    speed = tempspeed;
    size = tempsize;
  }
  void streak()
  {
    position.y = position.y + speed;
  }
  void checkPosition()
  {
    if (position.y < (height/2) + 55 && position.y > (height/2) + 45)
    {
      speed = 0;
      fill(currbg);
      noStroke();
      ellipse(position.x, position.y, size + 2, size + 2);
    }
  }
  void display()
  {
    fill(255, 0, 0);
    ellipse(position.x, position.y, size, size);
  }
}

