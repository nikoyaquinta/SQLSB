sp_change_users_login @Action='Report';


Para vilcularlos:
sp_change_users_login @Action='update_one', @UserNamePattern='<database_user>',  @LoginName='<login_name>';

sp_change_users_login @Action='update_one', @UserNamePattern='roracciatti',  @LoginName='roracciatti';