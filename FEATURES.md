All visible features in this app should work as shown.

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


Files and folders of significance:

```
spec/
views/
models/
controllers/
reports/ (CSV files are saved here)
```