const fs = require('fs');
const path = require('path');

const docsDir = path.join(__dirname, '../docs');
const outputFile = path.join(__dirname, '../docs/apps_data.js');

function getTitle(filePath) {
    const content = fs.readFileSync(filePath, 'utf8');
    const titleMatch = content.match(/<title>(.*?)<\/title>/i);
    return titleMatch ? titleMatch[1] : path.basename(filePath, '.html');
}

function syncApps() {
    try {
        const files = fs.readdirSync(docsDir);
        const htmlFiles = files.filter(file => file.endsWith('.html') && file !== 'index.html');

        const apps = htmlFiles.map(file => {
            const filePath = path.join(docsDir, file);
            return {
                name: getTitle(filePath),
                path: file,
                filename: file
            };
        });

        const content = `// This file is auto-generated. Do not edit manually.
const APPS_DATA = ${JSON.stringify(apps, null, 4)};`;

        fs.writeFileSync(outputFile, content);
        console.log(`Successfully synced ${apps.length} apps (index.html excluded).`);
    } catch (error) {
        console.error('Error syncing apps:', error);
    }
}

syncApps();
