<!-- default file list -->
*Files to look at*:

* [CustomEvents.cs](./CS/T259265/CustomEvents.cs) (VB: [CustomEvents.vb](./VB/T259265/CustomEvents.vb))
* [Global.asax](./CS/T259265/Global.asax) (VB: [Global.asax](./VB/T259265/Global.asax))
* [Global.asax.cs](./CS/T259265/Global.asax.cs) (VB: [Global.asax](./VB/T259265/Global.asax))
* [Scheduler.aspx](./CS/T259265/Scheduler.aspx) (VB: [Scheduler.aspx.vb](./VB/T259265/Scheduler.aspx.vb))
* [Scheduler.aspx.cs](./CS/T259265/Scheduler.aspx.cs) (VB: [Scheduler.aspx.vb](./VB/T259265/Scheduler.aspx.vb))
<!-- default file list end -->
# How to make the scheduler take the entire container content


<p>This example demonstrates how to make the ASPxScheduler take the entire container content. The scheduler lies inside the <a href="https://documentation.devexpress.com/#AspNet/clsDevExpressWebASPxSplittertopic">ASPxSplitter</a> control. It automatically changes height depending on the window size.<br />The height is calculated on the client side. Then, the calculated value is applied to the <strong>ScrollAreaHeight </strong>property of the <a href="https://documentation.devexpress.com/AspNet/CustomDocument3804.aspx">Day View</a>, <a href="https://documentation.devexpress.com/AspNet/CustomDocument3805.aspx">Work-Week View</a> and <a href="https://documentation.devexpress.com/AspNet/CustomDocument17778.aspx">Full Week View</a> and <br />to the <strong>DateCellBody</strong> property of the <a href="https://documentation.devexpress.com/AspNet/CustomDocument3807.aspx">Month View</a>.<br />Review the <a href="https://documentation.devexpress.com/#AspNet/CustomDocument3846">How to: Set the Scheduler's Size</a> article to get more information about these properties.</p>

<br/>


