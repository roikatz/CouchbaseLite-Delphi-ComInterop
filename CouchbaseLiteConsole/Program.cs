using CouchbaseLiteManager;
using System;

namespace CouchbaseLiteConsole
{
    class Program
    {
        static void Main(string[] args)
        {

            var manager = new CouchbaseLiteFacade();
            manager.StartSyncGateway("localhost");
            Console.WriteLine("Manager and Databse Created");
            

            var properties =
            "{" +
                "\"name\": \"Roi Katz\", " +
                "\"age\": 31," +
                "\"database\" : \"Couchbase\"" +
            "}";

            var docInsertedId = manager.Insert(properties);
            Console.WriteLine("Doc-id: " + docInsertedId);

            var docGet = manager.Get(docInsertedId);
            Console.WriteLine("DocGet");
            Console.WriteLine(docGet);


            var newProperties =
                        "{" +
                            "\"name\": \"Roi Katz!\", " +
                            "\"age\": 32," +
                            "\"database\" : \"CB\"" +
                        "}";

            var updated = manager.Update(docInsertedId, newProperties);

            Console.WriteLine("DocGet update");
            Console.WriteLine(updated);

            var isDeleted = manager.Delete(docInsertedId);
            Console.WriteLine("Document deleted: {0}", isDeleted ? "Deleted" : "NotDeleted");

            manager.StopSyncGateway();
        }
    }
}
