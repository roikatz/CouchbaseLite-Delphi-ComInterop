using Couchbase.Lite;
using CouchbaseLiteManager;
using System;
using System.Windows;

namespace CouchbaseMobileWPF
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {

        CouchbaseLiteFacade _manager;
        string documentId;
        const string TAG = "CouchbaseEvents";
        const string DB_NAME = "couchbaseevents";

        private Database _db;

        public MainWindow()
        {
            InitializeComponent();
            _manager = new CouchbaseLiteFacade();
            _manager.StartSyncGateway();
        }

        private void InsertDocumentClick(object sender, RoutedEventArgs e)
        {
            var properties =
            "{" +
                "\"name\": \"Roi Katz\", " +
                "\"age\": 31," +
                "\"database\" : \"Couchbase\"" +
            "}";

            var docInsertedId = _manager.Insert(properties);
            MessageBox.Show("Doc-id: " + docInsertedId, "Insert");

            documentId = docInsertedId;
            id.Text = docInsertedId;
        }

        private void UpdateDocumentClick(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrEmpty(id.Text)) return;

            var newProperties =
                        "{" +
                            "\"name\": \"Roi Katz!\", " +
                            "\"age\": 32," +
                            "\"database\" : \"CB\"" +
                        "}";

            var updated = _manager.Update(id.Text, newProperties);
            MessageBox.Show(updated, "Update");

        }

        private void GetDocumentClick(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrEmpty(id.Text )) return;
           
            var docGet = _manager.Get(id.Text);
            
           MessageBox.Show(docGet);
        }

        private void DeleteDocumentClick(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrEmpty(id.Text)) return;

            var isDeleted = _manager.Delete(id.Text);
            var msg = string.Format("Document deleted: {0}", isDeleted ? "Deleted" : "NotDeleted");
            Console.WriteLine(msg);
            MessageBox.Show(msg);
           
            documentId = null;
        }
    }
}
