using System;
using System.Runtime.InteropServices;

namespace CouchbaseLiteManager
{

    [ComVisible(true)]
    [Guid("02113b7a-4864-4520-94cd-1542a2b0ff05")]
    public interface ICouchbaseLiteFacade
    {
        void StartSyncGateway(string url = "");

        void StopSyncGateway();

        string Insert(string propertiesJson);

        string Get(string docId);

        string Update(string documentJson, string updatedPropertiesJsons);

        bool Delete(string documentId);
    }
}
