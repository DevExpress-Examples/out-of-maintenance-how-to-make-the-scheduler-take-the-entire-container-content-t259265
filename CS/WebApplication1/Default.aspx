<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplication1.Default" %>

<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.ASPxScheduler.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxScheduler" TagPrefix="dxwschs" %>
<%@ Register Assembly="DevExpress.XtraScheduler.v17.1.Core, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraScheduler" TagPrefix="cc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <script src="http://code.jquery.com/jquery-2.0.3.js"></script>
    <script type="text/javascript">
        function AdjustCalendarSize(s, e) {
            var view = clientScheduler.GetActiveViewType();
            var commonElementsHeight = GetCommonSchedulerElementsHeight();
            if (view == "Day" || view == "FullWeek" || view == "WorkWeek") {
                var h = splMain.GetHeight();
                if (h > 0) {
                    var h1 = $(".dxscDayHdrsContainer")[0].offsetHeight;
                    $(".dxscDayScrollContainer")[0].style.height = (h - h1 - commonElementsHeight) + "px";
                    $(".dxscDayScrollBodyTable")[0].style.height = (h - h1 - commonElementsHeight) + "px";
                }
            }
            if (view == "Timeline") {
                var h = splMain.GetHeight();
                if (h > 0) {
                    var h1 = $(".dxsc-timeline-scalesContainer")[0].offsetHeight;
                    $(".dxsc-timeline-commonContainer")[0].style.height = (h - h1 - commonElementsHeight) + "px";
                    $(".dxsc-timeline-resourcesContainer")[0].style.height = (h - h1 - commonElementsHeight) + "px";
                }
            }
            clientScheduler.adjustControlInternal();
        }

        function GetCommonSchedulerElementsHeight() {
            var result = 0;
            if ($("[class*='dxscToolbarContainer']").length > 0) result = result + $("[class*='dxscToolbarContainer']")[0].offsetHeight;
            if ($("[class*='dxscResourceNavigator']").length > 0) result = result + $("[class*='dxscResourceNavigator']")[0].offsetHeight;
            return result;
        }
    </script>
    <form id="form1" runat="server">
        <div>
            <dx:ASPxSplitter ID="splMain" runat="server" FullscreenMode="True" Width="100%" Height="100%"
                SaveStateToCookies="False" ShowCollapseBackwardButton="true" ClientSideEvents-PaneResized="AdjustCalendarSize">
                <Panes>
                    <dx:SplitterPane Name="CalendarPane">
                        <PaneStyle>
                            <Paddings Padding="0" />
                        </PaneStyle>
                        <ContentCollection>
                            <dx:SplitterContentControl ID="SplitterContentControl1" runat="server">
                                <dxwschs:ASPxScheduler ID="ASPxScheduler1" runat="server" AppointmentDataSourceID="ObjectDataSourceAppointment"
                                    ClientIDMode="AutoID" Start='<%#DateTime.Now%>' GroupType="Date" ClientInstanceName="clientScheduler"
                                    ResourceDataSourceID="ObjectDataSourceResources" OnCustomJSProperties="ASPxScheduler1_CustomJSProperties">
                                    <ClientSideEvents EndCallback="AdjustCalendarSize" Init="AdjustCalendarSize" />
                                    <Storage>
                                        <Appointments AutoRetrieveId="True">
                                            <Mappings
                                                AllDay="AllDay"
                                                AppointmentId="Id"
                                                Description="Description"
                                                End="EndTime"
                                                Label="Label"
                                                Location="Location"
                                                ReminderInfo="ReminderInfo"
                                                ResourceId="OwnerId"
                                                Start="StartTime"
                                                Status="Status"
                                                Subject="Subject"
                                                Type="EventType" />
                                        </Appointments>
                                        <Resources>
                                            <Mappings
                                                Caption="Name"
                                                ResourceId="ResID" />
                                        </Resources>
                                    </Storage>

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
                                            <MonthViewStyles DateCellBody-Height="100%" />
                                        </MonthView>
                                        <WeekView Enabled="false" />
                                        <TimelineView Enabled="true">
                                            <TimelineViewStyles ScrollAreaHeight="100%" />
                                        </TimelineView>
                                    </Views>
                                </dxwschs:ASPxScheduler>
                            </dx:SplitterContentControl>
                        </ContentCollection>
                    </dx:SplitterPane>
                </Panes>
            </dx:ASPxSplitter>

            <asp:ObjectDataSource ID="ObjectDataSourceResources" runat="server" OnObjectCreated="ObjectDataSourceResources_ObjectCreated" SelectMethod="SelectMethodHandler" TypeName="WebApplication1.CustomResourceDataSource"></asp:ObjectDataSource>
            <asp:ObjectDataSource ID="ObjectDataSourceAppointment" runat="server" DataObjectTypeName="WebApplication1.CustomAppointment" DeleteMethod="DeleteMethodHandler" InsertMethod="InsertMethodHandler" SelectMethod="SelectMethodHandler" TypeName="WebApplication1.CustomAppointmentDataSource" UpdateMethod="UpdateMethodHandler" OnObjectCreated="ObjectDataSourceAppointment_ObjectCreated"></asp:ObjectDataSource>
        </div>
    </form>
</body>
</html>
