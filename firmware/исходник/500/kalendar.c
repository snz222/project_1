//Глобальные переменные
char answer;
int Day, Month, Year;
int Day2, Month2, Year2;
//какой сегодня день недели
char NameDaysToday[2];

//названия дней недели
 const char* NameDaysOfWeek[] = {
                "ВС", "ПН", "ВТ",
                "СР", "ЧТ", "ПТ", "СБ"
                }; 
                
//Определяет высокосный года или нет
bool LeapYear(int Year) 
 {
     if(Year % 4 == 0 && Year % 100 != 0 || Year % 400 == 0) 
     return 1;
     else
     return 0;
 }

//Проверка правильности и коректности ввода данных
bool check(int Year,int Month, int Day)
{
if (( Month==1 || Month==3 || Month==5 || Month==7 || Month==8 || Month==10 || Month==12) && (Day > 31)) 
            return 0;           
            
if ((Month==4 || Month==6 || Month==9 || Month==11) && (Day > 30)) 
            return 0;           
            
if (Month==2 & (!LeapYear(Year)) & (Day>29)) 
            return 0;       
            
if (Month<1 || Month>12) 
            return 0;
            
if(Year<2014||Year>2222) 
            return 0;
            
else
return 1;
}
 
//Вычисление дня недели
int find(int Year,int Month, int Day)
{   
//cout<<Day<<"|"<<Month<<"|"<<Year; 
char i;
int Century;
int DayOfWeek;
//Вычисление дня недели по формуле Зеллера
if (Month > 2) 
    Month -= 2; 
else 
    Month += 10, Year--;    
Century = Year / 100;
    Year %= 100;
DayOfWeek = (Day + (13 * Month - 1) / 5 + Year + Year / 4 - Century * 2 + Century / 4) % 7; 
if (DayOfWeek < 0) 
    DayOfWeek += 7;

//очистка строки
memset(NameDaysToday, 0, sizeof(NameDaysToday));

for (i=0;i<sizeof(NameDaysOfWeek[DayOfWeek]);i++)
{
NameDaysToday[i]=NameDaysOfWeek[DayOfWeek][i];
}     
return 0;
}  


// 
 // Определение количество дней между введённой датой и текущей
 //сначало текущая, потом та что была ранее установлена, можно поправить код внизу
int between(int Day, int Month, int Year, int Day2, int Month2, int Year2)
{
int n1, n2;
//struct tm *Date;
//    time_t now;
//    time( &now );
//Date = localtime( &now );
//cout<< "Current date is \n"<<asctime( Date )<<endl;
//  Day2=Date->tm_mday;
//  Month2=Date->tm_mon+1;
//  Year2=Date->tm_year+1900;   
 
    if( Month>2 )
    {
        Month = Month+1;
    }
    else
    {
        Month = Month+13;
        Year = Year-1;
    }
    n1 = 36525*Year/100+306*Month/10+Day;
 
    if( Month2>2 )
    {
        Month2 = Month2+1;
    }
    else
    {
        Month2 = Month2+13;
        Year2 = Year2-1;
    }
    n2 = 36525*(Year2)/100+306*(Month2)/10+Day2;
 
//if(n2>n1) 
    //cout<<"Date was "<<n2-n1<<" days ago"<<endl; 
    //else
if(n2<n1)
    //cout<<"Date will be "<<n1-n2<<" days"<<endl; 
    return n1-n2; 
    //else
//if(n2==n1)
//    cout<<"Put today's date"<<endl<<endl;


}