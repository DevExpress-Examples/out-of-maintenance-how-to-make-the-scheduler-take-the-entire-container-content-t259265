<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Scheduler.aspx.cs" Inherits="T259265.Scheduler" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="http://code.jquery.com/jquery-2.0.3.js"></script>
    <script type="text/javascript">
        function AdjustCalendarSize(s, e) {
            var view = scheduler.GetActiveViewType();
            if (view == "Day" || view == "FullWeek" || view == "WorkWeek") {
                var h = splMain.GetHeight();
                if (h > 0) {
                    var h1 = $(".dxscDayHdrsContainer")[0].offsetHeight;
                    var h2 = $("[class*='dxscToolbarContainer']")[0].offsetHeight;
                    $(".dxscDayScrollContainer")[0].style.height = (h - h1 - h2) + "px";
                    $(".dxscDayScrollBodyTable")[0].style.height = (h - h1 - h2) + "px";
                }
            }
            if (view == "Month") {
                var h3 = splMain.GetHeight();
                if (h3 > 0) {
                    var h4 = $("[class*='dxscToolbar']")[0].offsetHeight;
                    var h5 = $("[class*='dxscDayHeader']")[0].offsetHeight;
                    var h6 = $("[class*='dxscDateCellHeader']")[0].offsetHeight;
                    var weekCount = document.getElementById('HiddenField1').value;
                    var res = (h3 - h4 - h5 - h6 * weekCount) / weekCount + "px";
                    $("[class*='dxscDateCellBody']").css("height", res);
                }
            }
            scheduler.OnWindowResized();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:HiddenField ID="HiddenField1" runat="server" />
            <asp:ObjectDataSource ID="appointmentDataSource" runat="server" OnObjectCreated="appointmentDataSource_ObjectCreated"
                DataObjectTypeName="T259265.CustomEvent" TypeName="T259265.CustomEventDataSource"
                DeleteMethod="DeleteMethodHandler" SelectMethod="SelectMethodHandler"
                InsertMethod="InsertMethodHandler" UpdateMethod="UpdateMethodHandler"></asp:ObjectDataSource>
            <dx:ASPxSplitter ID="splMain" runat="server" FullscreenMode="True" Width="100%" Height="100%"
                SaveStateToCookies="False" ShowCollapseBackwardButton="true" ClientSideEvents-PaneResized="AdjustCalendarSize">
                <Panes>
                    <dx:SplitterPane Name="CalendarPane">
                        <PaneStyle>
                            <Border BorderWidth="0" />
                            <Paddings Padding="0" />
                        </PaneStyle>
                        <ContentCollection>
                            <dx:SplitterContentControl ID="SplitterContentControl1" runat="server">
                                <dx:ASPxScheduler ID="schedulerControl" runat="server" ActiveViewType="Day"
                                    AppointmentDataSourceID="appointmentDataSource" ClientInstanceName="scheduler" OnAppointmentRowInserted="schedulerControl_AppointmentRowInserted">
                                    <ClientSideEvents EndCallback="AdjustCalendarSize" />
                                    <Views>
                                        <DayView>
                                            <DayViewStyles ScrollAreaHeight="100%" />
                                        </DayView>
                                        <WorkWeekView>
                                            <WorkWeekViewStyles ScrollAreaHeight="100%" />
                                        </WorkWeekView>
                                        <FullWeekView Enabled="true">
                                            <FullWeekViewStyles ScrollAreaHeight="100%" />
                                        </FullWeekView>
                                        <MonthView>
                                            <MonthViewStyles DateCellBody-Height="100" />
                                        </MonthView>
                                        <WeekView Enabled="false" />
                                        <TimelineView Enabled="false" />
                                    </Views>
                                    <Storage>
                                        <Appointments>
                                            <Mappings AppointmentId="Id" Start="StartTime" End="EndTime" Subject="Subject" AllDay="AllDay"
                                                Description="Description" Label="Label" Location="Location" RecurrenceInfo="RecurrenceInfo"
                                                ReminderInfo="ReminderInfo" Status="Status" Type="EventType" />
                                        </Appointments>
                                    </Storage>
                                </dx:ASPxScheduler>
                            </dx:SplitterContentControl>
                        </ContentCollection>
                    </dx:SplitterPane>
                </Panes>
            </dx:ASPxSplitter>
        </div>
    </form>
</body>
</html>
