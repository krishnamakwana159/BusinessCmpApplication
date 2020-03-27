using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessCmpApp
{
    class Program
    {
        static void Main(string[] args)
        {
            Program p = new Program();
            var dbContext = new BusinessCmpDbEntities();
            bool flag = true;
            int choice;
            do
            {
                Console.WriteLine("1. Admin \n2. Project Manager \n3. Exit");
                Console.WriteLine("Enter Your Choice: ");
                choice = Convert.ToInt32(Console.ReadLine());
                switch (choice)
                {
                    case 1:
                        p.Admin();
                        break;

                    case 2:
                        p.ProjectManagerFun();
                        break;

                    case 3:
                        flag = false;
                        break;

                    default:
                        Console.WriteLine("Invalid Choice !!!");
                        break;

                }
            }
            while (choice != 3);
        }
            private void Admin()
            {
                bool f = false;
                int choice;
                do
                {
                    Console.WriteLine("1. Add Employee Details \n2. Assign Project to Manager \n3. Show Project Employees \n4. Show Project Managers \n5. Add Unit \n6. Show Units \n7. Exit");
                    Console.WriteLine("Enter Your Choice: ");
                    choice = Convert.ToInt32(Console.ReadLine());
                    switch (choice)
                    {
                        case 1:
                            AddEmployee();
                            break;

                        case 2:
                            AssignProjectManager();
                            break;

                        case 3:
                            EmployeeList();
                            break;

                        case 4:
                            ProjectManagerList();
                            break;

                        case 5:
                            AddUnit();
                            break;

                        case 6:
                            UnitList();
                            break;

                        case 7:
                            f = false;
                            break;

                        default:
                            Console.WriteLine("Invalid Choice !!!");
                            break;
                    }

                } while (choice!=7);
            }
            private void ProjectManagerFun()
            {
                bool f = false;
                int choice;
                do
                {
                    Console.WriteLine("1. Show Employee Details \n2. Show Project Manager \n3. Assign Project to Employee \n4. Show Projects \n5. Exit");
                    Console.WriteLine("Enter Your Choice: ");
                    choice = Convert.ToInt32(Console.ReadLine());
                    switch (choice)
                    {
                        case 1:
                            EmployeeList();
                            break;
                        case 2:
                            ProjectManagerList();
                            break;
                        case 3:
                            AssignProject();
                            break;
                        case 4:
                            ProjectList();
                            break;
                        case 5:
                            f = false;
                            break;
                        default:
                            Console.WriteLine("Invalid Choice !!");
                            break;
                    }
                } while (choice!=5);
            }
            public void AddEmployee()
            {
                using (var dbContext = new BusinessCmpDbEntities())
                {
                    var employee = new Employee();

                    Console.WriteLine("Enter Empployee Name: ");
                    employee.Name = Console.ReadLine();

                    Console.WriteLine("Enter Empployee Address: ");
                    employee.Address = Console.ReadLine();

                    Console.WriteLine("Enter Empployee Gender: ");
                    employee.Gender = Console.ReadLine();

                    Console.WriteLine("Enter Empployee Contact no: ");
                    employee.ContactNo = Convert.ToInt32(Console.ReadLine());

                    Console.WriteLine("Enter Unit Id in which Employee belongs : ");
                    UnitList();
                    employee.UnitId = Convert.ToInt32(Console.ReadLine());

                    var check = dbContext.Employees.SingleOrDefault(t => t.Name == employee.Name);
                    if (check == null)
                    {
                        try
                        {
                            dbContext.Employees.Add(employee);
                            dbContext.SaveChanges();
                            Console.WriteLine("Employee added !!");
                        }
                        catch (Exception e)
                        {
                            Console.WriteLine(e);
                        }
                    }
                    else
                    {
                        Console.WriteLine("Employee is already in the list");
                    }
                }
            }
            public void AssignProjectManager()
            {
                using (var dbContext = new BusinessCmpDbEntities())
                {
                    Console.WriteLine("Select Id  : ");
                 
                    var list = dbContext.EmplpoyeeDetails;
                    foreach(var i in list)
                    {
                        Console.WriteLine("Id :" + i.EmployeeDetailId + "\tEmployee Id: "+ i.EmployeeId + "\tProject Id: "+ i.ProjectId);
                    }
                    
                    var pm = new ProjectManager();
                    pm.EmployeeDetailId = Convert.ToInt32(Console.ReadLine());

                    var check = dbContext.ProjectManagers.SingleOrDefault(t => t.EmployeeDetailId == pm.EmployeeDetailId);
                    if (check == null)
                    {
                        try
                        {
                            dbContext.ProjectManagers.Add(pm);
                            dbContext.SaveChanges();
                            Console.WriteLine("Project manager is assigned to a project !!");
                        }
                        catch (Exception e)
                        {
                            Console.WriteLine(e);
                        }
                    }
                    else
                    {
                        Console.WriteLine("Manager is already assigned to project");
                    }
                }
            }
            public void AssignProject()
            {
                var dbContext = new BusinessCmpDbEntities();
                var emp = new EmplpoyeeDetail();
                Console.WriteLine("Select Project Id : ");
                ProjectList();
                emp.ProjectId = Convert.ToInt32(Console.ReadLine());

                Console.WriteLine("Select Employee Id : ");
                EmployeeList();
                emp.EmployeeId = Convert.ToInt32(Console.ReadLine());

                var check = dbContext.EmplpoyeeDetails.SingleOrDefault(t => t.EmployeeId == emp.EmployeeId);
                var c = dbContext.EmplpoyeeDetails.SingleOrDefault( t => t.ProjectId == emp.ProjectId);
                if (check == null && c==null)
                {
                    try
                    {
                        dbContext.EmplpoyeeDetails.Add(emp);
                        dbContext.SaveChanges();
                        Console.WriteLine("Assigned a project to employee  !!");
                    }
                    catch (Exception e)
                    {
                        Console.WriteLine(e);
                    }
                }
                else
                {
                    Console.WriteLine("Project is already assigned to employee");
                }

            }
            public void AddUnit()
            {
                using(var dbContext = new BusinessCmpDbEntities())
                {
                    var unit = new Unit();

                    Console.WriteLine("Enter Unit Name: ");
                    unit.UnitName = Console.ReadLine();

                    var check = dbContext.Units.SingleOrDefault(t => t.UnitName == unit.UnitName);
                    if (check == null)
                    {
                        try
                        {
                            dbContext.Units.Add(unit);
                            dbContext.SaveChanges();
                            Console.WriteLine("Unit added to the list");
                        }
                        catch (Exception e)
                        {
                            Console.WriteLine(e);
                        }
                    }
                    else
                    {
                        Console.WriteLine("Unit is already in the list");
                    }
                }
            }
            public void ProjectList()
            {
                var dbContext = new BusinessCmpDbEntities();
                var pList = dbContext.Projects;
                Console.WriteLine("---------------Project List-------------");
                foreach (var e in pList)
                {
                    Console.WriteLine("Project Id: " +  + e.ProjectId + "\tUnit Name : " + e.Unit.UnitName + "\tProject Title: " + e.ProjectTitle);
                }
            }
           public void UnitList()
            {
                var dbContext = new BusinessCmpDbEntities();
                var uList = dbContext.Units;
                Console.WriteLine("---------------Unit List---------------");
                foreach (var e in uList)
                {
                    Console.WriteLine("Unit Id: "+ e.UnitId + "\tUnit Name : " + e.UnitName );
                }
            }
            public void EmployeeList()
            {
                var dbContext = new BusinessCmpDbEntities();
                var employeeList = dbContext.vProjectEmployeeDetails;
                Console.WriteLine("---------------Employee List---------------");
                foreach (var e in employeeList)
                {
                Console.WriteLine("Employee Id : " + e.EmployeeId + "\tEmployee Name : " + e.Name + "\tEmployee Address : " + e.Address +
                    "\tContact No : " + e.ContactNo + "\tGender : " + e.Gender + "\tUnit Name" + e.UnitName +  "\tProject Title : " + e.ProjectTitle);
                }
            }
            public void  ProjectManagerList()
            {
                var dbContext = new BusinessCmpDbEntities();
                var list = dbContext.vManagerDetails;
                Console.WriteLine("---------------Project Manager List---------------");
                foreach (var e in list)
                {
                Console.WriteLine("Manager Id : " + e.ProjectManagerId + "\tName : " + e.Name + "\tAddress : " +
                        e.Address + "\tContact No : " + e.ContactNo + "\tGender : " + e.Gender +
                        "\tUnit Name" + e.UnitName + "\tProject Title : " + e.ProjectTitle);
            }
            var l = new EmplpoyeeDetail();

            }
        }
    }

