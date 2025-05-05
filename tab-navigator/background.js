chrome.commands.onCommand.addListener((command) => {
    if (command === "next_tab") {
        chrome.tabs.query({ currentWindow: true }, (tabs) => {
            chrome.tabs.query(
                { active: true, currentWindow: true },
                (activeTabs) => {
                    if (activeTabs.length === 0) return;
                    let activeIndex = activeTabs[0].index;
                    let nextIndex = (activeIndex + 1) % tabs.length;
                    chrome.tabs.update(tabs[nextIndex].id, { active: true });
                },
            );
        });
    } else if (command === "previous_tab") {
        chrome.tabs.query({ currentWindow: true }, (tabs) => {
            chrome.tabs.query(
                { active: true, currentWindow: true },
                (activeTabs) => {
                    if (activeTabs.length === 0) return;
                    let activeIndex = activeTabs[0].index;
                    let previousIndex =
                        (activeIndex - 1 + tabs.length) % tabs.length;
                    chrome.tabs.update(tabs[previousIndex].id, {
                        active: true,
                    });
                },
            );
        });
    }
});
