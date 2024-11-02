<?php

namespace App\Livewire\Karyawan;

use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Livewire\Component;
use Livewire\WithPagination;

class Show extends Component
{
    use WithPagination;

    protected $listeners = ['karyawanAdded' => '$refresh'];

    public $name;

    public $email;

    public $address;

    public $password;

    public $updatename;

    public $updateemail;

    public $updateaddress;

    public $selectedUser;

    public function render()
    {
        return view('livewire.karyawan.show', [
            'users' => User::paginate(10),
        ]);
    }

    public function deleteKaryawan(User $user)
    {
        $user->delete();
        session()->flash('successhapus', 'Data karyawan berhasil dihapus.');
    }

    public function resetForm()
    {
        $this->reset();
        $this->resetValidation();
    }

    public function save()
    {
        $validated = $this->validate([
            'name' => 'required|max:255',
            'email' => 'required|email|max:255|unique:users,email',
            'address' => 'required|max:255',
        ], [
            'name.required' => 'Nama wajib diisi.',
            'name.max' => 'Nama tidak boleh lebih dari 255 karakter.',
            'email.required' => 'Email wajib diisi.',
            'email.email' => 'Email tidak valid.',
            'email.max' => 'Email tidak boleh lebih dari 255 karakter.',
            'email.unique' => 'Email sudah digunakan oleh pengguna lain.',
            'address.required' => 'Alamat wajib diisi.',
            'address.max' => 'Alamat tidak boleh lebih dari 255 karakter.',
        ]);

        User::create([
            'name' => $validated['name'],
            'email' => $validated['email'],
            'address' => $validated['address'],
            'password' => Hash::make('Gumukmas123'), // Default password
        ]);

        session()->flash('success', 'Data karyawan berhasil ditambahkan.');
        $this->resetForm();
    }

    public function resetEditForm()
    {
        $this->reset(['updatename', 'updateemail', 'updateaddress', 'selectedUser']);
        $this->resetValidation();
    }

    public function edit(User $user)
    {
        $this->selectedUser = $user;
        $this->updatename = $user->name;
        $this->updateemail = $user->email;
        $this->updateaddress = $user->address;

        // dd($this->selectedUser, $this->updatename, $this->updateemail, $this->updateaddress);
    }

    public function update($userId)
    {
        $validatedData = $this->validate([
            'updatename' => 'required|string|max:255',
            'updateemail' => 'required|email|unique:users,email,'.$userId,
            'updateaddress' => 'required|string|max:255',
        ]);

        $user = User::findOrFail($userId);
        $user->update([
            'name' => $this->updatename,
            'email' => $this->updateemail,
            'address' => $this->updateaddress,
        ]);
        session()->flash('successedit', 'Data karyawan berhasil diupdate.');

        // Reset form fields
        $this->resetEditForm();
    }
}
