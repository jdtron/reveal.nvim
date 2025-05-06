<script>
    import 'reveal.js/dist/reveal.css';
    import 'reveal.js/dist/theme/dracula.css';
    import 'reveal.js/plugin/highlight/monokai.css';
    import Reveal from 'reveal.js/dist/reveal.js';
    import Markdown from 'reveal.js/plugin/markdown/markdown.js';
    import Highlight from 'reveal.js/plugin/highlight/highlight.js';
    import Notes from 'reveal.js/plugin/notes/notes.js';
    import Math from 'reveal.js/plugin/math/math.js';
    import { untrack } from 'svelte';

    const LAST_SLIDE = 'lastSlide';
    const TTL = 1000 * 60 * 60; // 1h

    const { data } = $props();
    const markdown = data.markdown.split("\n\n---\n\n").map(n => n.trim());
    let sections = [];

    let deck = $state();

    for (let sect of markdown) {
        let slides = [];
        for (let slide of sect.split("\n\n\n")) {
            slides.push(slide);
        }
        sections.push(slides);
    }

    const onSlideChanged = ({ indexh, indexv }) => {
        localStorage.setItem(LAST_SLIDE, JSON.stringify({
            indexh,
            indexv,
            exp: new Date(new Date().getTime() + TTL),
        }))
    }

    $effect(() => {
        untrack(async () => {
            if (!deck) {
                const lastSlide = localStorage.getItem(LAST_SLIDE);
                let { indexh, indexv, exp } = lastSlide
                    ? JSON.parse(lastSlide)
                    : { indexh: 0, indexv: 0, exp: 0 };

                if (new Date(exp) <= new Date()) {
                    indexh = 0;
                    indexv = 0;
                }

                let deck = new Reveal({
                    slideNumber: 'h.v',
                    plugins: [Markdown, Highlight, Notes, Math],
                });
                await deck.initialize();
                deck.addEventListener('slidechanged', onSlideChanged);
                deck.slide(indexh, indexv);
            }
        });
    })
</script>

{#each sections as sect}
    <section>
        {#each sect as sub}
            <section data-markdown>
                {sub}
            </section>
        {/each}
    </section>
{/each}
