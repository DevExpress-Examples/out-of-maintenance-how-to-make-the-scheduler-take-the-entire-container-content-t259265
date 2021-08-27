<!-- default badges list -->
![](https://img.shields.io/endpoint?url=https://codecentral.devexpress.com/api/v1/VersionRange/128547397/19.1.5%2B)
[![](https://img.shields.io/badge/Open_in_DevExpress_Support_Center-FF7200?style=flat-square&logo=DevExpress&logoColor=white)](https://supportcenter.devexpress.com/ticket/details/T259265)
[![](https://img.shields.io/badge/📖_How_to_use_DevExpress_Examples-e9f6fc?style=flat-square)](https://docs.devexpress.com/GeneralInformation/403183)
<!-- default badges end -->
<!-- default file list -->

# How to make the scheduler take the entire container content

<strong>Starting with v19.1</strong> you can use the <a href="https://docs.devexpress.com/AspNet/js-ASPxClientScheduler.SetHeight(height)">SetHeight</a> method to stretch ASPxScheduler dynamically on the client. Call this method in the <a href="https://docs.devexpress.com/AspNet/js-ASPxClientControlBase.Init">ASPxClientScheduler.Init</a> and <a href="https://docs.devexpress.com/AspNet/js-ASPxClientScheduler.EndCallback">ASPxClientScheduler.EndCallback</a> events and on resizing the browser window. You can handle the <a href="https://docs.devexpress.com/AspNet/js-ASPxClientGlobalEvents.BrowserWindowResized">ASPxClientGlobalEvents.BrowserWindowResized</a> event to catch the moment of browser resizing.
<br/>

<strong>For versions prior to 19.1</strong>
<p>This example demonstrates how to make the ASPxScheduler take the entire container content. The scheduler lies inside the <a href="https://documentation.devexpress.com/#AspNet/clsDevExpressWebASPxSplittertopic">ASPxSplitter</a> control. It automatically changes height depending on the window size.<br />The height is calculated on the client side. Then, the calculated value is applied to the <strong>ScrollAreaHeight </strong>property of the <a href="https://documentation.devexpress.com/AspNet/CustomDocument3804.aspx">Day View</a>, <a href="https://documentation.devexpress.com/AspNet/CustomDocument3805.aspx">Work-Week View</a> and <a href="https://documentation.devexpress.com/AspNet/CustomDocument17778.aspx">Full Week View</a> and <br />to the <strong>DateCellBody</strong> property of the <a href="https://documentation.devexpress.com/AspNet/CustomDocument3807.aspx">Month View</a>.<br />Review the <a href="https://documentation.devexpress.com/#AspNet/CustomDocument3846">How to: Set the Scheduler's Size</a> article to get more information about these properties.</p>

<br/>


