Add-Type -assembly System.Windows.Forms
$main_form = New-Object System.Windows.Forms.Form
$main_form.Text ='Fire-Tools'
$main_form.Width = 600
$main_form.Height = 400
$main_form.AutoSize = $true
$main_form.ShowDialog()

$Button = New-Object System.Windows.Forms.Button

$Button.Location = New-Object System.Drawing.Size(400,10)

$Button.Size = New-Object System.Drawing.Size(120,23)

$Button.Text = "Check"

$main_form.Controls.Add($Button)