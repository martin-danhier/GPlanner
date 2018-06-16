// Base class by Xaphok

using System;
using System.Collections.Generic;
using System.Text;

namespace GPlanner.Classes
{
    /// <summary>
    /// A task is something that the user has to do. Tasks are displayed in "ToDoListPage".
    /// </summary>
    class TaskToDo //The name "Task" is already taken by System.Threading.Tasks
    {
        // ========== PROPERTIES ==========

            //REQUIRED
        public string Name { get; private set; }

            //OPTIONAL
        public Orientation Orientation { get; private set; } // work, hobbies , ?
        public Importance Importance { get; private set; } //the higher the value, the higher the importance
        public string Place { get; private set; }
        public DateTime Deadline { get; private set; }
        public DateTime PlannedFor { get; private set; }
        public string Description { get; private set; }
        public byte PercentageCompleted { get; private set; }

        public bool IsPlanned { get; private set; }
        public bool HasDeadline { get; private set; }

        // public ? Repeat { get; private set; } // Repeat this task every day/week/month...

        // ========== CONSTRUCTORS ==========
        public TaskToDo(string name, string description = "No description", DateTime plannedFor = new DateTime(), DateTime deadline = new DateTime(),  Importance importance = Importance.Normal, string place = "", byte percentageCompleted = 0 )
        {
            Name = name;
            Importance = importance;
            Deadline = deadline;
            PlannedFor = plannedFor;
            Place = place;
            IsPlanned = (PlannedFor > DateTime.Now);
            HasDeadline = (Deadline > DateTime.Now);
            if (percentageCompleted >= 0 && percentageCompleted <= 100)
                PercentageCompleted = percentageCompleted;
            else
                throw new Exception("Percentage must be between 0 and 100.");
            
           // Deadline = deadline;
           // PlannedFor = plannedFor;
           // Repeat = repeat;
              
        }

        // ========== METHODS ==========
 
    }

    // ========== ENUMS ==========
    public enum Orientation { Work, Hobby, None } //others ?
    public enum Importance { Low, Normal, High }
}
