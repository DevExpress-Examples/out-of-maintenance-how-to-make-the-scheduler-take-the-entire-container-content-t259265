using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.ComponentModel;
using DevExpress.XtraScheduler;
using DevExpress.Web.ASPxScheduler;

namespace T259265 {
    public partial class Scheduler : System.Web.UI.Page {
        CustomEventDataSource objectInstance;
        Random rnd = new Random();
        string[] Users = new string[] { "Peter Dolan", "Ryan Fischer", "Andrew Miller" };

        protected void Page_Load(object sender, EventArgs e) {
            schedulerControl.Storage.Appointments.AutoRetrieveId = true;
            FillResources(schedulerControl.Storage, 3);
            HiddenField1.Value = schedulerControl.MonthView.WeekCount.ToString();
        }

        protected void appointmentDataSource_ObjectCreated(object sender, ObjectDataSourceEventArgs e) {
            this.objectInstance = new CustomEventDataSource(GetCustomEvents());
            e.ObjectInstance = this.objectInstance;
        }

        protected void schedulerControl_AppointmentRowInserted(object sender, DevExpress.Web.ASPxScheduler.ASPxSchedulerDataInsertedEventArgs e) {
            e.KeyFieldValue = this.objectInstance.ObtainLastInsertedId();
        }

        CustomEventList GetCustomEvents() {
            CustomEventList events = Session["ListBoundModeObjects"] as CustomEventList;
            if(events == null) {
                events = GenerateCustomEventList();
                Session["ListBoundModeObjects"] = events;
            }
            return events;
        }

        void FillResources(ASPxSchedulerStorage storage, int count) {
            ResourceCollection resources = storage.Resources.Items;
            storage.BeginUpdate();
            try {
                int cnt = Math.Min(count, Users.Length);
                for(int i = 1; i <= cnt; i++) {
                    Resource resource = storage.CreateResource(i);
                    resource.Caption = Users[i - 1];
                    resources.Add(resource);
                }
            } finally {
                storage.EndUpdate();
            }
        }

        #region Random events generation
        CustomEventList GenerateCustomEventList() {
            CustomEventList eventList = new CustomEventList();
            int count = schedulerControl.Storage.Resources.Count;
            for(int i = 0; i < count; i++) {
                Resource resource = schedulerControl.Storage.Resources[i];
                string subjPrefix = resource.Caption + "'s ";

                eventList.Add(CreateEvent(resource.Id, subjPrefix + "meeting", 2, 5));
                eventList.Add(CreateEvent(resource.Id, subjPrefix + "travel", 3, 6));
                eventList.Add(CreateEvent(resource.Id, subjPrefix + "phone call", 0, 10));
            }
            return eventList;
        }
        CustomEvent CreateEvent(object resourceId, string subject, int status, int label) {
            CustomEvent customEvent = new CustomEvent();
            customEvent.Subject = subject;
            customEvent.OwnerId = resourceId;
            int rangeInHours = 48;
            customEvent.StartTime = DateTime.Today + TimeSpan.FromHours(rnd.Next(0, rangeInHours));
            customEvent.EndTime = customEvent.StartTime + TimeSpan.FromHours(rnd.Next(0, rangeInHours / 8));
            customEvent.Status = status;
            customEvent.Label = label;
            customEvent.Id = "ev" + customEvent.GetHashCode();
            return customEvent;
        }
        #endregion
    }
}