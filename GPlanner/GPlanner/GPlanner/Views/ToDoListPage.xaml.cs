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
        public List<TaskToDo> trash;
        int restoringId;
        public List<int> trashIndex;
        TaskList tasks;
        public ToDoListPage()
        {

            InitializeComponent();
            trash = new List<TaskToDo>();
            trashIndex = new List<int>();
            toDo = new List<TaskToDo>
            {
            new TaskToDo("Buy some eggs", 1,  "One pack or two",plannedFor: new DateTime(2018,06,20), place:"shop"),
            new TaskToDo("Complete GPlanner", 2,  "Soon..."),
            new TaskToDo("Go outside", 3,  "Because it's sunny", place:"Outside", plannedFor: new DateTime(2018,07,01), deadline: new DateTime(2018,09,15))
            };
            tasks = new TaskList(toDo);
            ToDoList.ItemsSource = tasks.Items;
            
        }

        private async void CheckboxCheckChanged(object sender, EventArgs e)
        {
            CheckBox checkBox = sender as CheckBox;
            TaskToDo task = (from itm in tasks.Items
                             where itm.Id == Convert.ToInt32(checkBox.Text)
                             select itm).FirstOrDefault<TaskToDo>();
            Grid grid = checkBox.Parent as Grid;
            if (Settings.EnableAnimations)
            {
                #pragma warning disable CS4014
                grid.FadeTo(0.3, 100);
                #pragma warning restore CS4014
                await grid.ScaleTo(0.9, 100, Easing.SinIn);
            }
            trash.Add(task);
            trashIndex.Add(tasks.Items.IndexOf(task));
            if (trash.Count > Settings.ToDoListTrashSize)
            {
                trash.RemoveAt(0);
                trashIndex.RemoveAt(0);
            }
            tasks.Items.Remove(task);
            UndoLayout.IsVisible = true;
            if (Settings.EnableAnimations)
            {
                await UndoLayout.FadeTo(1, 100);
            }
            else
            {
                UndoLayout.Opacity = 1;
            }
        }

        private async void UndoButtonClicked(object sender, EventArgs e)
        {
            if (trash.Count > 0)
            {
                TaskToDo taskToRestore = trash.Last();
                int removingIndex = trashIndex.Last();
                restoringId = taskToRestore.Id;
                trash.RemoveAt(trash.Count - 1);
                trashIndex.RemoveAt(trashIndex.Count - 1);
                tasks.Items.Insert(removingIndex, taskToRestore);
                if (trash.Count == 0)
                {
                    if (Settings.EnableAnimations) { 
                    await UndoLayout.FadeTo(0, 100);}
                    UndoLayout.IsVisible = false;
                }
            }
        }

        private async void ViewCellAppearing(object sender, EventArgs e)
        {
                ViewCell view = sender as ViewCell;
                Grid grid = view.View as Grid;
                CheckBox checkBox = grid.Children[1] as CheckBox;
                if (checkBox.Text == restoringId.ToString() && Settings.EnableAnimations)
                {

                    grid.Scale = 0.9;
                    grid.IsVisible = true;
                    await grid.ScaleTo(1, 100, Easing.SinOut);
                    restoringId = 0;

                }
                else
                {
                    grid.IsVisible = true;
                }
            


        }

    }
}