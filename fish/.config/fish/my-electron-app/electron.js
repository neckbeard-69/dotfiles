import { app, BrowserWindow } from 'electron';
import { join, dirname } from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

function createWindow() {
    const win = new BrowserWindow({
        width: 800,
        height: 600,
        webPreferences: {
            preload: join(__dirname, 'preload.js'),
        },
    });

    if (process.env.NODE_ENV === 'development') {
        // win.loadURL('http://localhost:5173');
        win.loadURL('https://google.com');
        win.webContents.openDevTools();
        return;
    }
    win.loadFile(join(__dirname, 'dist/index.html'));
}

app.whenReady().then(() => {
    createWindow();

    app.on('activate', () => {
        if (BrowserWindow.getAllWindows().length === 0) createWindow();
    });
});

app.on('window-all-closed', () => {
    if (process.platform !== 'darwin') app.quit();
});
