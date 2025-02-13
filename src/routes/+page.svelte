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
    const initReveal = () => {
        let deck = new Reveal({
            plugins: [Markdown, Highlight, Notes, Math],
        });
        deck.initialize();
    }

</script>

<section data-markdown>
    <div type="text/template">
        { data.markdown }
    </div>
</section>

{ initReveal() }
