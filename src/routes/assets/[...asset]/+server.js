import { error } from '@sveltejs/kit';
import fs from 'node:fs';
import path from 'node:path';

const ASSETS_DIR = 'assets';

export async function GET({ params }) {
    let absPath = path.resolve(path.join(ASSETS_DIR, params.asset));

    if (! absPath.startsWith(process.cwd())) {
        return error(403, 'Forbidden');
    }
    if (! fs.existsSync(absPath)) {
        return error(404, 'Not Found');
    }

    return new Response(fs.readFileSync(absPath));
}
