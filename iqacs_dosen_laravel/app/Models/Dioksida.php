<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Dioksida extends Model
{
    use HasFactory;

    protected $table = 'dioksida';

    protected $fillable = ['id_alat', 'nilai_dioksida'];
}
