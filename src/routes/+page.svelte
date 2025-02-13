<script>
    import 'reveal.js/dist/reveal.css';
    import 'reveal.js/dist/theme/dracula.css';
    import 'reveal.js/plugin/highlight/monokai.css';
    import Reveal from 'reveal.js/dist/reveal.js';
    import Markdown from 'reveal.js/plugin/markdown/markdown.js';
    import Highlight from 'reveal.js/plugin/highlight/highlight.js';
    import Notes from 'reveal.js/plugin/notes/notes.js';
    import Math from 'reveal.js/plugin/math/math.js';

    const { data } = $props();
    const markdown = data.markdown.split("\n\n---\n\n").map(n => n.trim());
    let sections = [];

    for (let sect of markdown) {
        let slides = [];
        for (let slide of sect.split("\n\n\n")) {
            slides.push(slide);
        }
        sections.push(slides);
    }

    const initReveal = () => {
        let deck = new Reveal({
            plugins: [Markdown, Highlight, Notes, Math],
        });
        deck.initialize();
    }

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

{ initReveal() }
