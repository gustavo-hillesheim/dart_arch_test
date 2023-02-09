The project follows the following architectural rules:

- Classes inside the 'entity' folder can only depend in other classes inside of it, or of outside packages. Their name should also end in 'Entity';
- Classes inside the 'repository' folder should extends from 'BaseRepository' and only import classes from the 'repository' or 'entity' folder or outside packages. Their name should also end in 'Repository';
- Classes inside the 'service' folder can only import classes from the 'repository' and 'entity' folders, as well as outside packages. Their name should also end in 'Service';
- Classes inside the 'controller' folder can import classes from everywhere. Their name should end in 'Controller'.