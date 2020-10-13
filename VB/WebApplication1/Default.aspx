<%@ Page Language="vb" AutoEventWireup="true" CodeBehind="Default.aspx.vb" Inherits="WebApplication1.Default" %>

<%@ Register Assembly="DevExpress.Web.v19.1, Version=19.1.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.ASPxScheduler.v19.1, Version=19.1.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxScheduler" TagPrefix="dxwschs" %>
<%@ Register Assembly="DevExpress.XtraScheduler.v19.1.Core, Version=19.1.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraScheduler" TagPrefix="cc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="height: 100%">
    <script type="text/javascript">
        function adjustSchedulerHeight(s, e) {
            clientScheduler.SetHeight(window.innerHeight - 20);
        }
    </script>
    <form style="height: 100%" id="form1" runat="server">
        <dx:ASPxGlobalEvents ID="ASPxGlobalEvents1" runat="server">
            <ClientSideEvents BrowserWindowResized="adjustSchedulerHeight" />
        </dx:ASPxGlobalEvents>
        <dxwschs:ASPxScheduler ID="ASPxScheduler1" runat="server" AppointmentDataSourceID="ObjectDataSourceAppointment"
			ClientIDMode="AutoID" Start='<%#Date.Now%>' GroupType="Date" ClientInstanceName="clientScheduler"
            ResourceDataSourceID="ObjectDataSourceResources">
            <ClientSideEvents EndCallback="adjustSchedulerHeight" Init="adjustSchedulerHeight" />
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
        <asp:ObjectDataSource ID="ObjectDataSourceResources" runat="server" OnObjectCreated="ObjectDataSourceResources_ObjectCreated" SelectMethod="SelectMethodHandler" TypeName="WebApplication1.CustomResourceDataSource"></asp:ObjectDataSource>
        <asp:ObjectDataSource ID="ObjectDataSourceAppointment" runat="server" DataObjectTypeName="WebApplication1.CustomAppointment" DeleteMethod="DeleteMethodHandler" InsertMethod="InsertMethodHandler" SelectMethod="SelectMethodHandler" TypeName="WebApplication1.CustomAppointmentDataSource" UpdateMethod="UpdateMethodHandler" OnObjectCreated="ObjectDataSourceAppointment_ObjectCreated"></asp:ObjectDataSource>
    </form>
</body>
</html>