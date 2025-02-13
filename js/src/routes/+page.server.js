import fs from 'node:fs';

const mdErr = (msg) => {
    return `## Oops!\n${msg}`;
}

export const load = async ({ url }) => {
    let markdown = 'Nothing to see here...';

    try {
        const file = url.searchParams.get('file');
        if (!file) {
            throw new Error(mdErr('Please provide query parameter `file`'));
        }

        if (!fs.existsSync(file)) {
            throw new Error(mdErr(`File \`${file}\` does not exist`))
        }

        markdown = fs.readFileSync(file).toString();
    } catch (e) {
        markdown = e.message;
    } finally {
        return {
            markdown,
        };
    }
};
