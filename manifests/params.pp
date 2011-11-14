class cronapt::params {

	$packages = ['cron-apt']

	# The email address to send mail to.
	$cron_mail = 'root'

	# When to send email about the cron-apt results.
	# Value: error   (send mail on error runs)
	#        upgrade (when packages are upgraded)
	#        changes (mail when change in output from an action)
	#        output  (send mail when output is generated)
	#        always  (always send mail)
	#                (else never send mail)
	$cron_mail_on = 'error'

	# Which actions (files in this module) to enable
	$cron_actions = ['update', 'notify']

}
