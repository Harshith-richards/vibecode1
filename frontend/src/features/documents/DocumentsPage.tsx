import { useEffect } from 'react';
import * as signalR from '@microsoft/signalr';

export const DocumentsPage = () => {
  useEffect(() => {
    const c = new signalR.HubConnectionBuilder().withUrl('/hubs/notifications').withAutomaticReconnect().build();
    c.start();
    return () => { c.stop(); };
  }, []);

  return <div className="p-8"><h1 className="text-2xl">Documents</h1><p>Connected to SignalR notifications for revision events.</p></div>;
};
