Imports Microsoft.VisualBasic
Imports System
Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.ComponentModel
Imports DevExpress.XtraScheduler
Imports DevExpress.Web.ASPxScheduler

Namespace T259265
	Partial Public Class Scheduler
		Inherits System.Web.UI.Page
		Private objectInstance As CustomEventDataSource
		Private rnd As New Random()
		Private Users() As String = { "Peter Dolan", "Ryan Fischer", "Andrew Miller" }

		Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
			schedulerControl.Storage.Appointments.AutoRetrieveId = True
			FillResources(schedulerControl.Storage, 3)
		End Sub

		Protected Sub appointmentDataSource_ObjectCreated(ByVal sender As Object, ByVal e As ObjectDataSourceEventArgs)
			Me.objectInstance = New CustomEventDataSource(GetCustomEvents())
			e.ObjectInstance = Me.objectInstance
		End Sub

		Protected Sub schedulerControl_AppointmentRowInserted(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxScheduler.ASPxSchedulerDataInsertedEventArgs)
			e.KeyFieldValue = Me.objectInstance.ObtainLastInsertedId()
		End Sub

		Private Function GetCustomEvents() As CustomEventList
			Dim events As CustomEventList = TryCast(Session("ListBoundModeObjects"), CustomEventList)
			If events Is Nothing Then
				events = GenerateCustomEventList()
				Session("ListBoundModeObjects") = events
			End If
			Return events
		End Function

		Private Sub FillResources(ByVal storage As ASPxSchedulerStorage, ByVal count As Integer)
			Dim resources As ResourceCollection = storage.Resources.Items
			storage.BeginUpdate()
			Try
				Dim cnt As Integer = Math.Min(count, Users.Length)
				For i As Integer = 1 To cnt
					Dim resource As Resource = storage.CreateResource(i)
					resource.Caption = Users(i - 1)
					resources.Add(resource)
				Next i
			Finally
				storage.EndUpdate()
			End Try
		End Sub

		#Region "Random events generation"
		Private Function GenerateCustomEventList() As CustomEventList
			Dim eventList As New CustomEventList()
			Dim count As Integer = schedulerControl.Storage.Resources.Count
			For i As Integer = 0 To count - 1
				Dim resource As Resource = schedulerControl.Storage.Resources(i)
				Dim subjPrefix As String = resource.Caption & "'s "

				eventList.Add(CreateEvent(resource.Id, subjPrefix & "meeting", 2, 5))
				eventList.Add(CreateEvent(resource.Id, subjPrefix & "travel", 3, 6))
				eventList.Add(CreateEvent(resource.Id, subjPrefix & "phone call", 0, 10))
			Next i
			Return eventList
		End Function
		Private Function CreateEvent(ByVal resourceId As Object, ByVal subject As String, ByVal status As Integer, ByVal label As Integer) As CustomEvent
			Dim customEvent As New CustomEvent()
			customEvent.Subject = subject
			customEvent.OwnerId = resourceId
			Dim rangeInHours As Integer = 48
			customEvent.StartTime = DateTime.Today + TimeSpan.FromHours(rnd.Next(0, rangeInHours))
			customEvent.EndTime = customEvent.StartTime + TimeSpan.FromHours(rnd.Next(0, rangeInHours \ 8))
			customEvent.Status = status
			customEvent.Label = label
			customEvent.Id = "ev" & customEvent.GetHashCode()
			Return customEvent
		End Function
		#End Region

		Protected Sub schedulerControl_CustomJSProperties(ByVal sender As Object, ByVal e As DevExpress.Web.CustomJSPropertiesEventArgs)
			e.Properties.Add("cpWeekCount", (TryCast(sender, ASPxScheduler)).MonthView.WeekCount)
		End Sub
	End Class
End Namespace