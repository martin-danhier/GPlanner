//Page by xaphok
// Using "InputKit" by enisn : https://github.com/enisn/Xamarin.Forms.InputKit

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using GPlanner.Classes;
using Plugin.InputKit.Shared.Controls;
using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace GPlanner.Views
{
    [XamlCompilation(XamlCompilationOptions.Compile)]
    public partial class ToDoListPage : ContentPage
    {
        public List<TaskToDo> toDo;
        TaskList tasks;
        public ToDoListPage()
        {

            InitializeComponent();
            toDo = new List<TaskToDo>
            {
            new TaskToDo("Buy some eggs", 0,  "One pack or two",plannedFor: new DateTime(2018,06,20), place:"shop"),
            new TaskToDo("Complete GPlanner", 1,  "Soon..."),
            new TaskToDo("Go outside", 2,  "Because it's sunny", place:"Outside", plannedFor: new DateTime(2018,07,01), deadline: new DateTime(2018,09,15))
            };
            tasks = new TaskList(toDo);
            ToDoList.ItemsSource = tasks.Items;
            
        }

        public async void CheckboxCheckChanged(object sender, EventArgs e)
        {
            CheckBox checkBox = sender as CheckBox;
            TaskToDo task = (from itm in toDo
                             where itm.Id == Convert.ToInt32(checkBox.Text)
                             select itm).FirstOrDefault<TaskToDo>();
            Grid grid = checkBox.Parent as Grid;
            await grid.ScaleTo(0.8, 100, Easing.SinIn);
            tasks.Items.Remove(task);           
        }


    }
}