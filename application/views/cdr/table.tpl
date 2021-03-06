{* Designed to be loaded into a tab or a dialogue window *}

{* When making changes to this template please also make equivalent changes in search/results.tpl *}

{if $cdrs|@count eq 0}

	<p class="ui-state-highlight ui-corner-all highlight">There are no CDRs in the database for this period.</p>

{else}

	<table class="display" id="cdrlist">
	
		<thead>
			<tr>
				<th>Unique ID</th>
				<th>Date</th>
				<th>Time</th>
				<th>Caller ID</th>
				<th>Source</th>
				<th>Destination</th>
				<th>Context</th>
				<th>Last app.</th>
				<th>Duration</th>
				<th>Billable</th>
				<th>Disposition</th>
			</tr>
		</thead>
		
		<tbody>
		
		{foreach from=$cdrs key=uniqueid item=cdr}
		
			<tr>
				<td><a href="/cdr/view/?uid={$uniqueid}">{$uniqueid}</a></td>
				<td>{$cdr.calldate|strtotime|date_format:"%d/%m/%Y"}</td>
				<td>{$cdr.calldate|strtotime|date_format:"%H:%M:%S"}</td>
				<td><a href="/reports/number/?number={$cdr.clid}">{$cdr.clid}</a></td>
				<td><a href="/reports/number/?number={$cdr.src}">{$cdr.src}</a></td>
				<td><a href="/reports/number/?number={$cdr.dst}">{$cdr.dst}</a></td>
				<td>{$cdr.dcontext}</td>
				<td>{$cdr.lastapp}</td>
				<td>{$cdr.formatted_duration}</td>
				<td>{$cdr.formatted_billsec}</td>
				<td>{$cdr.disposition}</td>
			</tr>
		
		{/foreach}
		
		</tbody>
		
		<tfoot>
			<tr>
				<th colspan="8"></th>
				<th style="text-align: left;">{$totals.duration_formatted}</th>
				<th style="text-align: left;">{$totals.billsec_formatted}</th>
				<th></th>
			</tr>
		</tfoot>
	
	</table>
	
	<script type="text/javascript">
	
	// apply DataTables plugin to CDR list
	$('#cdrlist').dataTable({
		"bJQueryUI": true,
		"sPaginationType": "full_numbers",
		"bProcessing": true,
		"iDisplayLength": 25,
		"oLanguage": {
			"sInfo": "Showing _START_ to _END_ of _TOTAL_ CDRs.",
			"sLengthMenu": 'Display <select>{$menuoptions}</select> CDRs'
		},
		{literal}"aoColumns": [
			{"bSortable": false},
			{"bSortable": true, "sType": "uk_date"},
			{"bSortable": false},
			{"bSortable": true},
			{"bSortable": true},
			{"bSortable": true},
			{"bSortable": true},
			{"bSortable": true},
			{"bSortable": true},
			{"bSortable": true},
			{"bSortable": true}
		],{/literal}
		"fnDrawCallback": function () {
			$("#cdrlist_info").append("&nbsp;&nbsp;<button align='middle' id='csvbutton' class='button' onclick='downloadCSV();'><img src='/images/icons/csv.png' width='16' height='16' alt='CSV' border='0' align='top'>&nbsp;&nbsp;Export CSV file</button>");
		}
	});

	// apply button style to CSV button
	$('#csvbutton').button();

	// handle CSV download request
	function downloadCSV() {
		window.location = "/{$controller}/{$action}/?{$csvrequest}";
	}
	
	</script>

{/if}
