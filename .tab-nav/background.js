chrome.commands.onCommand.addListener((command) => {
    if (command === "next_tab") {
        chrome.tabs.query({ currentWindow: true }, (tabs) => {
            chrome.tabs.query({ active: true, currentWindow: true }, (activeTabs) => {
                let index = activeTabs[0].index;
                let next = (index + 1) % tabs.length;
                chrome.tabs.update(tabs[next].id, { active: true });
            });
        });
    }

    if (command === "prev_tab") {
        chrome.tabs.query({ currentWindow: true }, (tabs) => {
            chrome.tabs.query({ active: true, currentWindow: true }, (activeTabs) => {
                let index = activeTabs[0].index;
                let prev = (index - 1 + tabs.length) % tabs.length;
                chrome.tabs.update(tabs[prev].id, { active: true });
            });
        });
    }
});
