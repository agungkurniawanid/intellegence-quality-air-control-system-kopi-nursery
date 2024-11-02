<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <title>{{ config('app.name', 'Laravel') }}</title>

    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

    <!-- Scripts -->
    @vite('resources/css/app.css')


</head>
<style>
    body {
        background-color: #4C4B16;
        background-image: url('{{ asset('images/footer/footer.png') }}');
        background-size: cover;
        background-position: center;
        background-repeat: repeat;
    }
</style>

<body class="font-sans text-gray-900 antialiased">

    {{ $slot }}

</body>

</html>
