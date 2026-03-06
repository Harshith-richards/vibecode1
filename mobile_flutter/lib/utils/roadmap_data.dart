import '../models/day.dart';
import '../models/task.dart';
import '../models/week.dart';

List<WeekPlan> buildRoadmapData() {
  return [
    WeekPlan(
      id: 'w01',
      title: 'C# OOP — Classes, Inheritance, Interfaces',
      subtitle: 'Foundation sprint with daily coding',
      phase: 'phase-1',
      tags: const ['C# Basics', 'OOP', 'LinkedIn Setup'],
      days: [
        DayPlan(
          id: 'w01d01',
          label: 'MON',
          title: 'Setup + Classes & Objects',
          tasks: [
            Task(id: 'w01d01t01', title: 'Install VS 2022 + .NET SDK'),
            Task(id: 'w01d01t02', title: 'Watch 30 min C# OOP tutorial'),
            Task(id: 'w01d01t03', title: 'Build Person class + Greet()'),
            Task(id: 'w01d01t04', title: 'Push first commit to GitHub'),
          ],
        ),
        DayPlan(
          id: 'w01d02',
          label: 'TUE',
          title: 'Inheritance & Polymorphism',
          tasks: [
            Task(id: 'w01d02t01', title: 'Create Animal base class'),
            Task(id: 'w01d02t02', title: 'Override MakeSound() in Dog/Cat'),
            Task(id: 'w01d02t03', title: 'Test polymorphism with List<Animal>'),
            Task(id: 'w01d02t04', title: 'Commit with feat message'),
          ],
        ),
      ],
    ),
    WeekPlan(
      id: 'w02',
      title: 'LINQ Deep Dive + async/await + OOP Revision',
      subtitle: 'Cement your fundamentals',
      phase: 'phase-1',
      tags: const ['LINQ', 'async/await', '10 jobs/wk'],
      days: _summaryWeekDays('w02', [
        'Practice Where, Select, GroupBy, Aggregate',
        'Add async fake API call with Task.Delay',
        'Clean week 1 code and variable names',
      ]),
    ),
    WeekPlan(
      id: 'w03',
      title: 'ASP.NET Core MVC — Controllers + Views',
      subtitle: 'Start web development with MVC',
      phase: 'phase-2',
      tags: const ['ASP.NET MVC', 'Razor Views', 'Bootstrap 5'],
      days: _summaryWeekDays('w03', [
        'Create EmployeeManagement app shell',
        'Implement Employee controller + Index view',
        'Style with Bootstrap cards and table',
      ]),
    ),
    WeekPlan(
      id: 'w04',
      title: 'Entity Framework Core + SQL Server CRUD',
      subtitle: 'Connect app to real DB',
      phase: 'phase-2',
      tags: const ['EF Core', 'SQL Server', 'Code-First'],
      days: _summaryWeekDays('w04', [
        'Set up DbContext + migrations',
        'Implement CRUD forms with validation',
        'Use proper bootstrap feedback on actions',
      ]),
    ),
    WeekPlan(
      id: 'w05',
      title: 'Project Polish + Deploy + README',
      subtitle: 'Finish and deploy project #1',
      phase: 'phase-2',
      tags: const ['Deploy', 'Search & Filter', 'Live URL'],
      days: _summaryWeekDays('w05', [
        'Add search and filter',
        'Add basic role-based login',
        'Deploy and update resume',
      ]),
    ),
    WeekPlan(
      id: 'w06',
      title: 'ASP.NET Core Web API — REST Fundamentals',
      subtitle: 'Build your first API',
      phase: 'phase-3',
      tags: const ['Web API', 'REST', 'Postman'],
      days: _summaryWeekDays('w06', [
        'Create Product API project',
        'Implement 5 CRUD endpoints',
        'Document with Swagger + test in Postman',
      ]),
    ),
    WeekPlan(
      id: 'w07',
      title: 'JWT Authentication + Repository Pattern',
      subtitle: 'Secure and structure your API',
      phase: 'phase-3',
      tags: const ['JWT Auth', 'DI', 'Repository'],
      days: _summaryWeekDays('w07', [
        'Add register/login endpoints',
        'Generate JWT tokens + authorize endpoints',
        'Refactor to repository pattern',
      ]),
    ),
    WeekPlan(
      id: 'w08',
      title: 'API Polish + Deploy',
      subtitle: 'Finish project #2 portfolio API',
      phase: 'phase-3',
      tags: const ['Error Handling', 'Deploy API', 'README'],
      days: _summaryWeekDays('w08', [
        'Add global error handler',
        'Export Postman collection',
        'Deploy and publish docs',
      ]),
    ),
    WeekPlan(
      id: 'w09',
      title: 'Interview Prep — Technical Round',
      subtitle: 'Convert knowledge into interview answers',
      phase: 'phase-4',
      tags: const ['C# Q&A', 'SQL', 'Mock Interview'],
      days: _summaryWeekDays('w09', [
        'Answer top 20 C# questions',
        'Practice SQL joins/group by',
        'Record mock interview answers',
      ]),
    ),
    WeekPlan(
      id: 'w10',
      title: 'HR Prep + Follow-Ups + Final Push',
      subtitle: 'Close pipeline and land offers',
      phase: 'phase-4',
      tags: const ['HR Round', 'Follow-Up', 'Final Push'],
      days: _summaryWeekDays('w10', [
        'Polish resume and GitHub',
        'Message recruiters + follow-up',
        'Practice 90-second intro story',
      ]),
    ),
  ];
}

List<DayPlan> _summaryWeekDays(String weekId, List<String> goals) {
  return [
    DayPlan(
      id: '${weekId}d01',
      label: 'PLAN',
      title: 'Weekly Focus',
      tasks: goals
          .asMap()
          .entries
          .map((e) => Task(id: '${weekId}t${e.key + 1}', title: e.value))
          .toList(),
    ),
  ];
}
