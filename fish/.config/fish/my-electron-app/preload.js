// preload.js
import { contextBridge } from 'electron';

contextBridge.exposeInMainWorld('api', {
    // your exposed API here
});
