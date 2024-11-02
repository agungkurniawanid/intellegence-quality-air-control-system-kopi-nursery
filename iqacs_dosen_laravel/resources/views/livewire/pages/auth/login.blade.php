<?php

use App\Livewire\Forms\LoginForm;
use Illuminate\Support\Facades\Session;
use Livewire\Attributes\Layout;
use Livewire\Volt\Component;

new #[Layout('layouts.guest')] class extends Component {
    public LoginForm $form;

    /**
     * Handle an incoming authentication request.
     */
    public function login(): void
    {
        $this->validate();

        $this->form->authenticate();

        Session::regenerate();

        $this->redirectIntended(default: route('dashboard', absolute: false), navigate: true);
    }
};
?>

<div class="min-h-screen flex flex-col justify-center items-center pt-6 sm:pt-0 bg-dgreen-100">
    <div class="text-center mb-6">
        <a href="/" wire:navigate>
            <img src="{{ asset('images/logo-kopi.png') }}" class="w-20 h-20 mx-auto">
        </a>
    </div>

    <div class="w-full sm:max-w-md mt-6 px-6 py-4 overflow-hidden sm:rounded-2xl">
        <div>
            <!-- Session Status -->
            <x-auth-session-status class="mb-4" :status="session('status')" />

            <!-- Custom Styles -->
            <form wire:submit.prevent="login" class="max-w-md bg-white mx-auto p-4 shadow-md rounded-lg">
                <div class="text-center mt-4">
                    <h1 class="text-2xl font-bold text-black">Login</h1>
                    <p class="text-gray-600 mt-2">Selamat datang di website Greenhouse Kopi Nursery</p>
                </div>

                <!-- Email Address -->
                <div class="mt-4">
                    <label for="email" class="block text-sm font-medium text-gray-700">Email</label>
                    <input wire:model="form.email" id="email" class="mt-1 p-2 border rounded-lg w-full"
                        type="email" name="email" required autofocus placeholder="Masukkan Email Anda" />
                    @error('form.email')
                        <p class="text-sm text-red-600">{{ $message }}</p>
                    @enderror
                </div>

                <!-- Password -->
                <div class="mt-4">
                    <label for="password" class="block text-sm font-medium text-gray-700">Password</label>
                    <div class="relative">
                        <input wire:model="form.password" id="password" placeholder="Masukkan Password Anda"
                            :type="show ? 'password' : 'text'" class="mt-1 p-2 border rounded-lg w-full">
                        <div class="absolute inset-y-0 right-0 pr-3 flex items-center text-sm leading-5">
                            <svg class="h-6 text-gray-700 cursor-pointer" fill="none" @click="show = !show"
                                x-show="!show" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
                                <path fill="currentColor"
                                    d="M572.52 241.4C518.29 135.59 410.93 64 288 64S57.68 135.64 3.48 241.41a32.35 32.35 0 0 0 0 29.19C57.71 376.41 165.07 448 288 448s230.32-71.64 284.52-177.41a32.35 32.35 0 0 0 0-29.19zM288 400a144 144 0 1 1 144-144 143.93 143.93 0 0 1-144 144zm0-240a95.31 95.31 0 0 0-25.31 3.79 47.85 47.85 0 0 1-66.9 66.9A95.78 95.78 0 1 0 288 160z">
                                </path>
                            </svg>
                            <svg class="h-6 text-gray-700 cursor-pointer" fill="none" @click="show = !show"
                                x-show="show" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512">
                                <path fill="currentColor"
                                    d="M320 400c-75.85 0-137.25-58.71-142.9-133.11L72.2 185.82c-13.79 17.3-26.48 35.59-36.72 55.59a32.35 32.35 0 0 0 0 29.19C89.71 376.41 197.07 448 320 448c26.91 0 52.87-4 77.89-10.46L346 397.39a144.13 144.13 0 0 1-26 2.61zm313.82 58.1l-110.55-85.44a331.25 331.25 0 0 0 81.25-102.07a32.35 32.35 0 0 0 0-29.19C550.29 135.59 442.93 64 320 64a308.15 308.15 0 0 0-147.32 37.7L45.46 3.37A16 16 0 0 0 23 6.18L3.37 31.45A16 16 0 0 0 6.18 53.9l588.36 454.73a16 16 0 0 0 22.46-2.81l19.64-25.27a16 16 0 0 0-2.82-22.45zm-183.72-142l-39.3-30.38A94.75 94.75 0 0 0 416 256a94.76 94.76 0 0 0-121.31-92.21A47.65 47.65 0 0 1 304 192a46.64 46.64 0 0 1-1.54 10l-73.61-56.89A142.31 142.31 0 0 1 320 112a143.92 143.92 0 0 1 144 144c0 21.63-5.29 41.79-13.9 60.11z">
                                </path>
                            </svg>
                        </div>
                    </div>
                    @error('form.password')
                        <p class="text-sm text-red-600">{{ $message }}</p>
                    @enderror
                </div>

                <!-- Forgot Password -->
                <div class="mb-2 mt-2 flex justify-end">
                    <a class="text-sm text-black hover:text-black-100" href="{{ route('password.request') }}"
                        wire:navigate>
                        Forgot your password?
                    </a>
                </div>

                <!-- Submit Button -->
                <div class="flex items-center justify-center">
                    <button type="submit"
                        class="w-full px-4 py-2 text-white rounded-md hover:bg-lgreen focus:outline-none focus:bg-[#914F1E]"
                        style="background-color: #4C4B16;">
                        Masuk
                </div>
            </form>
        </div>
    </div>
</div>
