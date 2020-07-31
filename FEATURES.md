All visible features in this app should work as shown. This is a full stack app, with all created drivers and tasks stored in a database.

To start, go to http://localhost:3000/drivers to create drivers.

http://localhost:3000/tasks is the calendar w/ tasks for all drivers

http://localhost:3000/drivers/1/tasks would be the calendar for driver with id: 1. To generate csv's for a specific driver, click on "Generate CSV for 2020 tasks". All CSV's for the required time intervals will be in the `reports/` folder

http://localhost:3000/drivers/1/tasks/1/ would be the details for task with id: 1 (associated with driver with id: 1)



Extras:

- create, update, and delete drivers
- deleting a driver automatically deletes all of their tasks
- validation on drivers
  - must have a unique name
- validations on tasks
  - must have all attributes (tasks also must have a driver assigned upon create or update)
  - start time must come before the end time
  - no overlapping with an existing task
    - alternate time is suggested if an overlap is detected. The next available timeslot of the same length as the attempted submission will be suggested to the user
- unit tests with good coverage on models and requests for drivers and tasks (spec/ folder)
- error pages if you try to directly go to a URL for a driver or task that doesn't exist


Files and folders of significance:

```
spec/
views/
models/
controllers/
reports/ (CSV files are saved here)
```