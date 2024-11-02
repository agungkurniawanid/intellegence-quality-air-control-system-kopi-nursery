<div>
    @if (session()->has('success'))
        <div id="success-alert" class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative" role="alert">
            <strong class="font-bold">Success!</strong>
            <span class="block sm:inline">{{ session('success') }}</span>
            <span class="absolute top-0 bottom-0 right-0 px-4 py-3">
                <svg class="fill-current h-6 w-6 text-green-500" role="button" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><title>Close</title><path d="M14.348 14.849a1 1 0 010-1.414L9.414 10l4.934-4.935a1 1 0 10-1.415-1.415L8 8.586 3.064 3.651a1 1 0 10-1.415 1.415L6.586 10l-4.937 4.935a1 1 0 001.415 1.415L8 11.414l4.935 4.935a1 1 0 001.414 0z"/></svg>
            </span>
        </div>

        <script>
            setTimeout(function() {
                document.getElementById('success-alert').style.display = 'none';
            }, 1500);
        </script>
    @endif
</div>
