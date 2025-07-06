## Note Taking App

For this assignment, you will implement a 3-4 screen mini-app for taking notes.  First, implement a signup and login screen that integrates Firebase authentication with an email + password flow: a simple login screen that calls createUserWithEmailAndPassword for new users and signInWithEmailAndPassword for returning users, then routes to the main interface, which is displayed below.

                                                                                                                               Screenshot 2025-06-23 at 10.39.57.png

(If the list is empty(No note has been added yet.), display the centered hint “Nothing here yet—tap ➕ to add a note.”). Every new user who has not added any note yet should see this.

Implement the four CRUD operations:
await fetchNotes();          // read all notes from Firestore and display them

await addNote(text);         // add a note from the dialog

await updateNote(id, text);  // edit a note via the edit icon

await deleteNote(id);        // delete a note via the delete icon

Requirements
Make sure to follow a clean architecture that separates your UI from logic
Use a state management such as BloC/Cubit or Provider, or any other statemanaged to manage state. Don't use setState() for this assignment.
Show a SnackBar for every success or error.
Display a small loader only during the initial fetch.

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
