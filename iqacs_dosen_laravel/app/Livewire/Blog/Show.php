<?php

namespace App\Livewire\Blog;

use App\Models\Blog;
use Livewire\Component;
use Livewire\WithPagination;

class Show extends Component
{
    use WithPagination;

    public $judulblog;

    public $deskripsi;

    public $kategori;

    public function render()
    {
        return view('livewire.blog.show', [
            'blog' => Blog::paginate(10),
        ]);
    }

    public function deleteBlog(Blog $blog)
    {
        $blog->delete();
        session()->flash('success', 'Blog berhasil dihapus.');
    }
}
