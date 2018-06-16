//Page by xaphok
// Using "InputKit" by enisn : https://github.com/enisn/Xamarin.Forms.InputKit

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using GPlanner.Classes;

using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace GPlanner.Views
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class ToDoListPage : ContentPage
    {
        public ToDoListPage()
        {
            InitializeComponent();
            List<TaskToDo> toDo = new List<TaskToDo>
            {
            new TaskToDo("Buy some eggs", "One pack or two",plannedFor: new DateTime(2018,06,18), place:"shop"),
            new TaskToDo("Complete GPlanner", "Soon..."),
            new TaskToDo("Go outside", "Because it's sunny", place:"Outside", plannedFor: new DateTime(2018,07,01), deadline: new DateTime(2018,09,15))
            };
            ToDoList.ItemsSource = toDo;
            
        }
    }
}