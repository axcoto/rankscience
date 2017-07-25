# Modify these as needed

HTTP_SUCCESS = 200
HTTP_UNPROCESSABLE = 422
BASE_URL = 'https://rankscience.herokuapp.com/'
#BASE_URL = 'http://localhost:3000/'
# RESET_DB_COMMAND = 'pg_restore --clean -d glexport_development glexport_development.psql.dump'
RESET_DB_COMMAND = 'echo Hit Heroku, not local testing. Please comment this out for local test in spec/config.rb# mysql -u rs -prs rs_dev < glexport_development.mysql.dump'

YALMART_ID = 2
DOSTCO_ID = 3
